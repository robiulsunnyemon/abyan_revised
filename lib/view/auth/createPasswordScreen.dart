import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/utils/style/themdata.dart';
import 'package:abyansf_asfmanagment_app/view/auth/resendOTPScreen.dart';
import 'package:abyansf_asfmanagment_app/view/auth/signupScreen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/main_screen/home_screen.dart';
import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create New Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 40,
                fontWeight: AppStyles.weightBold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Type and confirm a secure new password for your amount',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(height: AppStyles.heightM),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Name'
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => HomeScreen(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: '§',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // text button //
          ],
        ),
      ),
    );
  }
}
