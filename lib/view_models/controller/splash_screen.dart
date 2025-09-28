import 'dart:async';
import 'package:abyansf_asfmanagment_app/view/auth/onbording_screen.dart';
import 'package:get/get.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';

class SplashController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<String> titles = [
    'Elevate Your World.',
    'Beyond First Class.',
    'Live Exceptionally.',
  ];

  final List<String> subtitles = [
    'Supercars that turn heads. Yachts that rule the seas.',
    'Curated Luxury Travel and elite Entertainment for your every desire.',
    'Tailored Lifestyle Services and discreet Professional Support, anytime, anywhere.',
  ];

  final List<String> images = [
    AssetPath.splashScreen1,
    AssetPath.splashScreen2,
    AssetPath.splashScreen3,
  ];

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentIndex.value < images.length - 1) {
        currentIndex.value++;
      } else {
        currentIndex.value = 0;
      }
    });
  }

  void onDotTap(int index) {
    currentIndex.value = index;
  }

  void onNext() {
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
    } else {
      Get.to(() => OnbordingScreen());
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
