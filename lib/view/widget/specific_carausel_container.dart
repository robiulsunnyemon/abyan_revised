
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/style/appStyle.dart';

class SpecificCarauselContainer extends StatelessWidget {
  final String imagePath;
  final String? title;
  final String? location;
  final String? personIcon;
  final String? clockIcon;
  final double? height;
  final double? width;

  const SpecificCarauselContainer({
    super.key,
    required this.imagePath,
    this.title,
    this.location,
    this.personIcon,
    this.clockIcon,
    this.height = 216,
    this.width = 296,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              title ?? '',
              style: const TextStyle(
                fontFamily: "Playfair Display",
                fontSize: 20, // replace with AppStyles.fontXL if needed
                fontWeight: FontWeight.bold, // AppStyles.weightBold
                color: Colors.white, // AppColors.lightWhite6
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                location != null
                    ? const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.white, // AppColors.lightWhite6
                )
                    : SizedBox(),
                Text(
                  location ?? '',
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: AppStyles.fontXS,
                    fontWeight: AppStyles.weightRegular,
                    letterSpacing: 0.1,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                personIcon != null
                    ? _iconContainer(personIcon ?? '')
                    : SizedBox(),
                SizedBox(width: 4.w),
                clockIcon != null
                    ? _iconContainer(clockIcon ?? '')
                    : SizedBox(),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _iconContainer(String asset) {
    return Container(
      height: 27,
      width: 34,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Image.asset(asset, scale: 4)),
    );
  }
}
