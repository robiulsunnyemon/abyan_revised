import 'package:flutter/material.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Container(
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hintText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: decreaseOnTap,
                    child: SvgPicture.asset(AssetPath.minusIcons),
                  ),
                  Text(counterText),
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
