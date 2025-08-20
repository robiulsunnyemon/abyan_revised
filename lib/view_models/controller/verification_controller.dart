import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  var timer;
  var start = 59.obs;
  var hasError = false.obs;
  var isVerifying = false.obs;

  final goldColor = const Color(0xFFD1B47F);

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    start.value = 59;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verifyCode(BuildContext context) async {
    isVerifying.value = true;
    hasError.value = false;

    final enteredCode = controllers.map((c) => c.text).join();
    await Future.delayed(const Duration(seconds: 2));

    const correctCode = '1234';
    if (enteredCode == correctCode) {
      isVerifying.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification successful!')),
      );
    } else {
      hasError.value = true;
      isVerifying.value = false;
    }
  }
}
