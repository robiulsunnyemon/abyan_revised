import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:flutter/material.dart';

Widget dayTimeRow(String day, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Text(
          day,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: AppStyles.fontS,
            fontWeight: AppStyles.weightRegular,
            color: AppColors.blackColor,
          ),
        ),
        Spacer(),
        Text(
          time,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: AppStyles.fontS,
            fontWeight: AppStyles.weightRegular,
            color: AppColors.blackColor,
          ),
        ),
      ],
    ),
  );
}