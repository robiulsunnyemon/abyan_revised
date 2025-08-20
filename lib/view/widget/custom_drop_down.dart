import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../utils/style/appColor.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? labelText;
  final List<String> type;

  CustomDropdown({
    super.key,
    required this.type,
    required this.hint,
    this.labelText,
  });

  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (labelText != null)
                  Text(
                    labelText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryDeepColor,
                      fontSize: 8,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                Text(
                  hint,
                  style: TextStyle(
                    color: const Color(0xFF6D6D6D),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            items: type
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            value: controller.selectedValue.value,
            onChanged: (value) {
              controller.selectedValue.value = value;
            },
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightLaserColor),
                borderRadius: BorderRadius.circular(4),
              ),
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            dropdownStyleData: const DropdownStyleData(maxHeight: 200),
            menuItemStyleData: const MenuItemStyleData(height: 40),
            iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down)),
            barrierLabel: 'hello',
          ),
        ),
      ),
    );
  }
}

class MyController extends GetxController {
  var selectedValue = RxnString(); // nullable reactive string
}
