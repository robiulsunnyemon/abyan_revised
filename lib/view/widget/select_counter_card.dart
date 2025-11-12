import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/assets_path.dart';
import '../../utils/style/appColor.dart';

class SelectCounterCard extends StatelessWidget {
  final String hintText;
  final String counterText;
  final VoidCallback increaseOnTap;
  final VoidCallback decreaseOnTap;
  const SelectCounterCard({
    super.key,
    required this.hintText,
    required this.counterText,
    required this.increaseOnTap,
    required this.decreaseOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration( 
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding:  EdgeInsets.only(left: 6,top: 8,bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
              Row(
                children: [
                  GestureDetector(
                    onTap: decreaseOnTap,
                    child: SvgPicture.asset(AssetPath.minusIcons),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 4.w,right: 4.w,bottom: 4.h),
                    child: Text(counterText,style: TextStyle(color: AppColors.hintWhiteColor),),
                  ),
                  GestureDetector(
                    onTap: increaseOnTap,
                    child: SvgPicture.asset(AssetPath.plusIcons),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
