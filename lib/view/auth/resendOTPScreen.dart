
import 'package:abyansf_asfmanagment_app/api_services/resend_otp_verification_screen/resend_otp_verification.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/view/auth/recovery_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResendOTPScreen extends StatelessWidget {
  const ResendOTPScreen({super.key});

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
              'Recover Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 30.sp,
                fontWeight: AppStyles.weightBold,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Enter the Email Address that you used when\nregister to recover your password, You will receive a\nVerification code.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 15,
                fontFamily: "inter",
              ),
            ),
            SizedBox(height: AppStyles.heightM),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),

            SizedBox(height: 20.h),
            // login button //
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async{
                      final response=await ResendOTPVerificationApiService.resendOTPRequest();
                      if(response.statusCode==200){
                        Get.to(()=>RecoveryVerificationScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
