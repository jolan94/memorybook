import 'package:flutter/material.dart';
import 'package:memorybook/components/global.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundImage: GlobalData.profilePhoto != null ? FileImage(GlobalData.profilePhoto!) : null,
                child: GlobalData.profilePhoto == null ? const Icon(Icons.person, size: 70) : null,
              ),
              const SizedBox(height: 20),
              Text(
                GlobalData.userData['name']!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Email: ${GlobalData.userData['email']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${GlobalData.userData['age']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Sex: ${GlobalData.userData['sex']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Country: ${GlobalData.userData['country']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
