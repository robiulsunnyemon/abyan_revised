
import 'package:get/get.dart';

class CarouselSliderControllers extends GetxController {
  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
    print("Current index updated to: $currentIndex");
  }
}
