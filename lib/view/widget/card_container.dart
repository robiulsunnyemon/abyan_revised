import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? image;
  const CardContainer({
    super.key, this.height=95, this.width=107, this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Image.asset(image ??'',scale: 4,)),

    );
  }
}