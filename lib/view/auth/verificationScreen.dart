import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verificationscreen extends StatelessWidget {
  const Verificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verification', style: AppTextStyle.bold30.copyWith(color: AppColors.goldenTextColor)),
              Text(
                'We sent Verification code to your Email address',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  textStyle: TextStyle(color: AppColors.white),
                  backgroundColor: Colors.transparent,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeFillColor: Colors.transparent,
                    errorBorderColor: AppColors.red,
                    inactiveColor: AppColors.lightGreyBorder,     // default
                    selectedColor: AppColors.lightGreyBorder,     // when selected
                    activeColor: AppColors.lightGreyBorder,



                    inactiveFillColor: Colors.transparent,
                    selectedFillColor: Colors.transparent,
                    disabledColor: AppColors.greyBackgroundColor,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  cursorColor: AppColors.white,

                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  }, appContext: context,
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    () => LoginScreen();
                  },
                  child: Text('Confirm'),
                ),
              ),
              SizedBox(height: 10.h,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Didn't receive a code!",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: AppColors.goldenTextColor,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 353,
                child: Text(
                  '00:59 sec',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.goldenTextColor,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
