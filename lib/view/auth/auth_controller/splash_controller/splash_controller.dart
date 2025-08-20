import 'dart:async';

import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:get/get.dart';

import '../../loginScreen.dart';

class SplashController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List<String> images = [
    AssetPath.splashScreen1,
    AssetPath.splashScreen2,
    AssetPath.splashScreen3,
  ];

  void splashIndex(){
    if(currentIndex.value < images.length-1){
      currentIndex++;
    } else {
      Get.offAll(()=>LoginScreen());
    }
    update();
  }
}
