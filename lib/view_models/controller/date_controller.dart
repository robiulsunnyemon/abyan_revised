import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }
}
