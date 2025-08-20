import 'package:abyansf_asfmanagment_app/view/auth/auth_controller/login_controller/login_controller.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/view/auth/resendOTPScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_controller/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login Here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 40,
                    fontWeight: AppStyles.weightBold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome back you’ve\nbeen missed!',
                  textAlign: TextAlign.center,
        
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(height: AppStyles.heightM),
                TextFormField(
                  controller: _loginController.emailTEController,
                  maxLines: 1,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _loginController.passwordTEController,
                  maxLines: 1,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 20),
        
                // text button //
                TextButton(
                  onPressed: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      color: Color(0xffAD8945),
                      fontSize: AppStyles.fontL,
                      fontFamily: "inter",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // login button //
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
        
        
                          _loginController.login(
                            email: _loginController.emailTEController.text,
                            password:
                                _loginController.passwordTEController.text,
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
                  ],
                ),
                SizedBox(height: 20),
                // text button //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: AppStyles.fontL,
                        fontFamily: "inter",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xffAD8945),
                          fontSize: AppStyles.fontL,
                          fontFamily: "inter",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
