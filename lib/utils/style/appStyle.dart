import 'package:flutter/material.dart';

class AppStyles {
  // Font Sizes
  static const double fontXS = 10.0;
  static const double fontS = 12.0;
  static const double fontM = 14.0;
  static const double fontL = 16.0;
  static const double fontXL = 18.0;
  static const double fontXXL = 22.0;
  static const double fontXXXL = 28.0;

  // Font Weights
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightRegular = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightBold = FontWeight.w700;

  // Padding
  static const EdgeInsets paddingXS = EdgeInsets.all(4.0);
  static const EdgeInsets paddingS = EdgeInsets.all(8.0);
  static const EdgeInsets paddingM = EdgeInsets.all(12.0);
  static const EdgeInsets paddingL = EdgeInsets.all(16.0);
  static const EdgeInsets paddingXL = EdgeInsets.all(24.0);

  //  Heights
  static const double heightXS = 20.0;
  static const double heightS = 40.0;
  static const double heightM = 60.0;
  static const double heightL = 80.0;
  static const double heightXL = 100.0;

  // MediaQuery-based responsive font
  static double responsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return baseFontSize * 0.85;
    } else if (screenWidth > 600) {
      return baseFontSize * 1.2;
    } else {
      return baseFontSize;
    }
  }

  //MediaQuery-based spacing
  static double screenHeightPercentage(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  static double screenWidthPercentage(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }
}
