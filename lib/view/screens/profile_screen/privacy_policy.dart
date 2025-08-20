import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomAppBar(title: 'Privacy & Policy'),
                Text('Privacy & Policy', style: AppTextStyle.bold30),
                Text(
                  'Updated on 5 may 2025',
                  style: TextStyle(
                    color: const Color(0xFF4E4E4E),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text('Introduction', style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'Welcome to ASF MANEGMENT. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our mobile app and related services.',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('How We Use Your Information', style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'Display listings and allow user interaction\nCreate and manage your account\nRespond to inquiries or support requests\nImprove app performance and features\nPrevent fraud or abuse\nSend app updates or notifications',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Sharing of Information', style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'Other users (only listing-related info like name/contact if permitted)\nService providers (e.g., cloud hosting, analytics)\nAuthorities, if required by law',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Your Rights', style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'Access your personal data\nCorrect or delete your data\nWithdraw consent\nOpt out of communications',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Changes to This Policy', style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'We may update this policy periodically. We will notify you of changes via the app or email. Continued use means you accept the revised policy.',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Children's Privacy", style: AppTextStyle.bold20),
                SizedBox(
                  width: 353,
                  child: Text(
                    'Our app is not intended for children under 13. We do not knowingly collect data from children.',
                    style: TextStyle(
                      color: const Color(0xFF4E4E4E),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
