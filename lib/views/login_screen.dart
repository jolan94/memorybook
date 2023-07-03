import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorybook/controllers/signin_controller.dart';
import 'package:memorybook/views/onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/diary.png",
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 25),
            Obx(() {
              if (signInController.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () async {
                    final userCredential = await signInController.signInAnonymously();
                    // Do something with the userCredential
                    Get.off(OnboardingScreen()); // Navigate to OnBoardingScreen
                  },
                  child: const Text('Sign in anonymously'),
                );
              }
            }),
            const SizedBox(height: 16),
            Obx(() {
              if (signInController.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () async {
                    signInController.isLoading.value = true; // Set isLoading to true
                    final userCredential = await signInController.signInWithGoogle();
                    signInController.isLoading.value = false; // Set isLoading to false
                    // Do something with the userCredential
                    if (userCredential != null) {
                      Get.off(OnboardingScreen()); // Navigate to OnBoardingScreen
                    } else {
                      Get.snackbar('Error', 'Failed to sign in with Google'); // Show error message
                    }
                  },
                  child: const Text('Sign in with Google'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
