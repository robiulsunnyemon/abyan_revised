import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';
import '../../../view_models/controller/splash_screen.dart';
import '../../auth/onbording_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final _controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
                () => Positioned.fill(
              child: Transform.rotate(
                angle: 0,
                child: AspectRatio(
                  aspectRatio: 5,
                  child: Image.asset(
                    _controller.images[_controller.currentIndex.value],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 100),
                    const Text(
                      'Elevate Your World.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 30,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(
                      width: 353,
                      child: Text(
                        'Supercars that turn heads. Yachts that rule the seas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => OnbordingScreen()),
                      child: Text(
                        'Skip',
                        style: AppTextStyle.bold16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                            () => Row(
                          children: List.generate(
                            _controller.images.length,
                                (index) => GestureDetector(
                              // onTap: _controller.currentIndex,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  width: _controller.currentIndex.value == index
                                      ? 16
                                      : 5,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: _controller.currentIndex.value == index
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: _controller.splashIndex,
                      child: const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
