import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnbordingScreen extends StatelessWidget {
  OnbordingScreen({super.key});

  final List<String> imagePaths = [
    "assets/images/image 1.png",
    "assets/images/image 2.png",
    "assets/images/image 3.png",
    "assets/images/image 4.png",
    "assets/images/image 5.png",
    "assets/images/image 6.png",
    "assets/images/image 7.png",
    "assets/images/image 8.png",
    "assets/images/image 9.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    physics: const NeverScrollableScrollPhysics(),
                    children: imagePaths.map((path) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(path, fit: BoxFit.cover),
                      );
                    }).toList(),
                  ),

                  // Gradient overlay //
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 400,
                    child: IgnorePointer(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(0, 255, 255, 255),
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: 353,
              child: Text(
                'Your World. Curated for Luxury.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Description
            SizedBox(
              width: 353,
              child: Text(
                'Supercars, yachts, travel, entertainment, lifestyle, and more exclusively tailored to your standards.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons //
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => SignupScreen()),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: AppColors.primaryColor),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontFamily: 'Playfair Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Terms and Conditions
            SizedBox(
              width: 343,
              child: Text(
                'By Continuing, you agree to L’invite’s terms of services and acknowledge you’ve read our privacy policy',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4F4F4F),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
