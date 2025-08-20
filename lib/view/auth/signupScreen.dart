import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'auth_controller/sign_up_controller/sign_up_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Request an account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 40.sp,
                  fontWeight: AppStyles.weightBold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Get started with your access in\njust a few steps.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: AppStyles.heightM),
              TextFormField(
                controller: _signUpController.nameTEController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _signUpController.emailTEController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _signUpController.whatsappTEController,
                decoration: InputDecoration(hintText: 'Whats app  Number'),
              ),
              SizedBox(height: 20.h),
              // login button //
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _signUpController.signup();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Send request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // text button //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: AppStyles.fontL,
                      fontFamily: 'Inter',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xffAD8945),
                        fontSize: AppStyles.fontL,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
