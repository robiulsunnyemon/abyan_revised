import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    fontFamily: "PlayfairDisplay",
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          fontFamily: 'PlayfairDisplay',
        ),
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xFFC7AE6A),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        shadowColor: const Color(0x99C7AE6A),
        elevation: 10,
      ),
    ),
    /*textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: AppStyles.fontXXL,
        fontWeight: AppStyles.weightBold,
        color: AppColors.blackColor,
      ),
    ),*/
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      hintStyle: TextStyle(
        color:AppColors.hintTextColor,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 1.50,
      ),
      fillColor: AppColors.secondaryColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
  );
}
