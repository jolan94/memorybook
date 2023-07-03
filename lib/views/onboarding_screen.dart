import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memorybook/components/global.dart';
import 'package:memorybook/views/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final countryController = TextEditingController();
  final sexController = TextEditingController();
  final imagePicker = ImagePicker();

  int currentIndex = 0;
  double progressValue = 0.0;

  List<String> countries = ['United States', 'Canada', 'Mexico', 'Brazil', 'Argentina'];
  List<String> sexes = ['Male', 'Female', 'Other'];

  void _storeValues() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final age = int.tryParse(ageController.text.trim());
    final country = countryController.text.trim();
    final sex = sexController.text.trim();

    // Validate name
    if (name.isEmpty) {
      Get.snackbar('Error', 'Please enter your name');
      return;
    }

    // Validate email
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }

    // Validate age
    if (age == null || age < 1) {
      Get.snackbar('Error', 'Please enter a valid age');
      return;
    }

    // Validate country
    if (country.isEmpty) {
      Get.snackbar('Error', 'Please select your country');
      return;
    }

    // Validate sex
    if (sex.isEmpty) {
      Get.snackbar('Error', 'Please select your sex');
      return;
    }

    // Store validated values in a separate file
    // (You can replace this with your own implementation)
    GlobalData.userData = {
      'name': name,
      'email': email,
      'age': age,
      'country': country,
      'sex': sex,
    };
    // Replace this with your own implementation
    // (e.g. writing to a local database, sending to a server, etc.)

    Get.offAll(HomeScreen());
  }

  Widget _buildContent() {
    switch (currentIndex) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What is your name?'),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
          ],
        );
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What is your email?'),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What is your date of birth?'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      // Calculate age based on date of birth
                      int age = DateTime.now().year - date.year;
                      age = (DateTime.now().month < date.month ||
                              (DateTime.now().month == date.month && DateTime.now().day < date.day))
                          ? age - 1
                          : age;
                      setState(() {
                        ageController.text = age.toString();
                      });
                    }
                  },
                  child: const Text('Pick Date of Birth'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                    ),
                    keyboardType: TextInputType.number,
                    enabled: false,
                  ),
                ),
              ],
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What country are you from?'),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: countryController.text,
              onChanged: (value) {
                setState(() {
                  countryController.text = value!;
                });
              },
              items: countries
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      ))
                  .toList(),
            ),
          ],
        );
      case 4:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What is your sex?'),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: sexController.text,
              onChanged: (value) {
                setState(() {
                  sexController.text = value!;
                });
              },
              items: sexes
                  .map((sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex),
                      ))
                  .toList(),
            ),
          ],
        );

      case 5:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('What is your profile photo?'),
            const SizedBox(height: 10),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: GlobalData.profilePhoto != null
                  ? Image.file(
                      GlobalData.profilePhoto!,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(),
            ),
            ElevatedButton(
              onPressed: kIsWeb
                  ? null
                  : () async {
                      final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          GlobalData.profilePhoto = File(pickedFile.path);
                        });
                      }
                    },
              child: const Text('Upload'),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progressValue,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildContent(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex--;
                        progressValue -= 0.2;
                      });
                    },
                    child: const Text('Previous'),
                  ),
                Text('Step ${currentIndex + 1} / 6'),
                ElevatedButton(
                  onPressed: () {
                    switch (currentIndex) {
                      case 0:
                        if (nameController.text.isNotEmpty) {
                          setState(() {
                            currentIndex++;
                            progressValue += 0.2;
                          });
                        }
                        break;
                      case 1:
                        if (emailController.text.isNotEmpty) {
                          setState(() {
                            currentIndex++;
                            progressValue += 0.2;
                          });
                        }
                        break;
                      case 2:
                        if (ageController.text.isNotEmpty) {
                          setState(() {
                            currentIndex++;
                            progressValue += 0.2;
                          });
                        }
                        break;
                      case 3:
                        if (countryController.text.isNotEmpty) {
                          setState(() {
                            currentIndex++;
                            progressValue += 0.2;
                          });
                        }
                        break;
                      case 4:
                        if (sexController.text.isNotEmpty) {
                          setState(() {
                            currentIndex++;
                            progressValue += 0.2;
                          });
                        }
                        break;
                      case 5:
                        // TODO: Validate profile photo variable
                        _storeValues();

                        break;
                    }
                  },
                  child: Text(currentIndex == 5 ? 'Complete' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    sexController.text = "Male";
    countryController.text = "United States";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }
}
