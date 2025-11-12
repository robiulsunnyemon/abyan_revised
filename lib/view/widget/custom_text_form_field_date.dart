import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      height: 90.h,
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
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppColors.white,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16,top: 2),
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
            ),
          ),
        ],
      ),
    );
  }
}
