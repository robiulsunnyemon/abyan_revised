import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CounterController extends GetxController {
  var minus = 0.obs;

  void decrease() {
    if(minus != 0){
      minus--;
    }
  }

  void increase() {
    minus++;
  }

  var counterAdultChildrenMap = <String, int>{
    "Children": 0,
    "Adults": 0,
  }.obs;

  void increment(String level) {
    counterAdultChildrenMap[level] = (counterAdultChildrenMap[level]! + 1);
    counterAdultChildrenMap.refresh();
  }

  void decrement(String level) {
    if(counterAdultChildrenMap[level]! > 0){
      counterAdultChildrenMap[level] = (counterAdultChildrenMap[level]! - 1);
      counterAdultChildrenMap.refresh();
    }
  }


}
