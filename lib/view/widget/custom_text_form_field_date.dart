import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldLevel extends StatelessWidget {
  final String headingText;
  final String levelText;
  final String hintText;
  final VoidCallback onTap;
  const CustomTextFormFieldLevel({
    super.key,
    required this.onTap,
    required this.headingText,
    required this.hintText,
    required this.levelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 7,
        children: [
          Text(
            headingText,
            style: TextStyle(
              color: AppColors.goldenTextColor,
              fontSize: 16,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: double.infinity,
            height: 63,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      levelText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.hintWhiteColor,
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      hintText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.hintWhiteColor,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
