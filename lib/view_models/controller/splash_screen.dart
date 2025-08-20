import 'dart:async';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final List<String> images = [
    AssetPath.splashScreen1,
    AssetPath.splashScreen2,
    AssetPath.splashScreen2,
  ];

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      currentIndex.value = (currentIndex.value + 1) % images.length;
    });
  }

  void onDotTap(int index) {
    currentIndex.value = index;
  }

  void onNext() {
    if (currentIndex.value == images.length - 1) {
      Get.toNamed('/onboarding');
    } else {
      currentIndex.value++;
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
