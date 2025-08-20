import 'package:flutter/material.dart';

class CarouselContainer extends StatelessWidget {
  final String imagePath;
  final String? title;
  final String? location;
  final String personIcon;
  final String clockIcon;
  final double? height;
  final double? width;
  final bool isNetworkImage;
  final bool isLocation;
  final VoidCallback? onTap;

  const CarouselContainer({
    super.key,
    required this.imagePath,
    this.title,
    this.location,
    required this.personIcon,
    required this.clockIcon,
    this.height = 216,
    this.width = 296,
    this.isNetworkImage = false,
    this.isLocation = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: isNetworkImage
                ? NetworkImage(imagePath)
                : AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                title ?? '',
                style: const TextStyle(
                  fontFamily: "PlayfairDisplay",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              isLocation
                  ? Row(
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        //const Spacer(),
                        // personIcon != null
                        //     ? _iconContainer(personIcon ?? '')
                        //     : SizedBox(),
                        // const SizedBox(width: 5),
                        // clockIcon != null
                        //     ? _iconContainer(clockIcon ?? '')
                        //     : SizedBox(),

                      ],
                    )
                  : SizedBox(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconContainer(String asset) {
    return Container(
      height: 28,
      width: 35.58,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white), // AppColors.primaryColor
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Image.asset(asset, scale: 4)),
    );
  }
}
