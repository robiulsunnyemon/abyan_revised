import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/style/appColor.dart';
import '../../view_models/controller/date_controller.dart';

class CustomDatePicker extends StatelessWidget {
  final String? labelText;
  CustomDatePicker({super.key, this.labelText});

  final DateController date = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(  // Removed Expanded from here
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: GestureDetector(
        onTap: () => date.selectDate(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(  // This Expanded is fine as it's inside the Row
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (labelText != null)
                      Text(
                        labelText!,
                        style: TextStyle(
                          color: AppColors.primaryDeepColor,
                          fontSize: 8,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d MMMM, y').format(date.selectedDate.value),
                      style: const TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    ));
  }
}
