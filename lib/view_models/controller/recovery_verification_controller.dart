import 'dart:async';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoveryVerificationController extends GetxController {
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  final goldColor = const Color(0xFFD1B47F);

  var start = 59.obs;
  Timer? timer;

  var hasError = false.obs;
  var isVerifying = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    start.value = 59;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(Get.context!).requestFocus(focusNodes[index - 1]);
    }
  }

  Future<void> verifyCode() async {
    isVerifying.value = true;
    hasError.value = false;

    final enteredCode = controllers.map((c) => c.text).join();
    await Future.delayed(const Duration(seconds: 2));

    const correctCode = '1234';

    if (enteredCode == correctCode) {
      isVerifying.value = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Verification successful!')),
      );
      Get.offAll(()=>LoginScreen());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Incorrect code. Please try again.')),
      );
      hasError.value = true;
      isVerifying.value = false;
    }
  }
}
