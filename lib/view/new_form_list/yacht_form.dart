import 'dart:convert';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/style/app_text_styles.dart';
import '../../api_services/form_api_services/form_api_services.dart';
import '../../utils/style/appColor.dart';
import '../widget/custom_bottom_bar.dart';

/// --- helpers ---
Map<String, dynamic> _removeNulls(Map<String, dynamic> m) {
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    if (v != null) out[k] = v;
  });
  return out;
}

String? _iso(DateTime? dt) => dt?.toIso8601String();

/// ==============================
/// GetX Controller: Yacht form
/// ==============================
class YachtFormController extends GetxController {
  // Dropdowns
  final RxnString yachtSize = RxnString();     // Big | Medium | Small
  final RxnString duration = RxnString();      // 2 hours | 3 hours | 4 hours | 5 hours+

  // Dates
  final Rxn<DateTime> fromDate = Rxn<DateTime>();
  final Rxn<DateTime> toDate = Rxn<DateTime>();

  // People & contact
  final RxString people = ''.obs;     // numeric text
  final RxString contact = ''.obs;    // phone / WhatsApp

  // (Optional) auth header
  String? authToken;

  int get peopleCount => int.tryParse(people.value.trim()) ?? 0;

  String? validate() {
    if (yachtSize.value == null) return "Please select yacht size.";
    if (duration.value == null) return "Please select duration.";
    if (fromDate.value == null) return "Please select start date.";
    if (toDate.value == null) return "Please select end date.";
    if (!toDate.value!.isAfter(fromDate.value!)) {
      return "End date must be after start date.";
    }
    if (peopleCount <= 0) return "Please enter how many people are going.";
    if (contact.value.trim().isEmpty) return "Please enter WhatsApp number.";
    return null;
  }

  Future<void> submitForm({
    required int id,
  }) async {
    // ✅ validate first
    final err = validate();
    if (err != null) {
      Get.snackbar('Validation failed', err, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // ✅ unwrap Rx / DateTime → ISO (no Rx/DateTime in payload)
    final Map<String, dynamic> data = _removeNulls({
      "subCategoryId": id,                          // or miniSubCategoryId per API
      "typeOfAccommodation": yachtSize.value,       // String?
      "location": { "from": duration.value },       // keep your structure
      "checkInDate": _iso(fromDate.value),          // String ISO
      "checkOutDate": _iso(toDate.value),           // String ISO
      "number of people": peopleCount,              // int
      "contact": contact.value.trim(),              // String
    });

    try {
      // debug
      // ignore: avoid_print
      print('REQUEST BODY (yacht) => $data');

      final response = await FormRequestApiServices.formRequest(
        data: data,
        url: "sub-category-bookings",
        // headers: {
        //   "Content-Type": "application/json",
        //   if (authToken != null) "Authorization": "Bearer $authToken",
        // },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Your form submitted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => const OrderPlaceScreen());
      } else {
        Get.snackbar(
          'Failed',
          'Server responded: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(.08),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(.08),
      );
    }
  }
}

/// ==============================
/// Local bindable dropdown (duplicate-safe)
/// ==============================
class _BindableDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final RxnString selected;
  final void Function(String?) onChanged;

  const _BindableDropdown({
    required this.items,
    required this.hint,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final unique = (items
        .where((e) => e.trim().isNotEmpty)
        .map((e) => e.trim())
        .toSet()
        .toList())
      ..sort();

    return Obx(() {
      final current = selected.value;
      final safeValue = (current != null && unique.contains(current)) ? current : null;

      return DropdownButtonHideUnderline(
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: safeValue,
            hint: Text(hint),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            items: unique
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );
    });
  }
}

/// ==============================
/// Local date field
/// ==============================
class _DateField extends StatelessWidget {
  final String label;
  final Rxn<DateTime> valueRx;
  final ValueChanged<DateTime> onChanged;

  const _DateField({
    required this.label,
    required this.valueRx,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final d = valueRx.value;
      final text = (d == null)
          ? label
          : "${d.day.toString().padLeft(2, '0')}-"
          "${d.month.toString().padLeft(2, '0')}-"
          "${d.year}";

      return InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: d ?? now,
            firstDate: DateTime(now.year - 1),
            lastDate: DateTime(now.year + 3),
          );
          if (picked != null) onChanged(picked);
        },
        child: Container(
          height: 48,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(color: d == null ? Colors.grey : Colors.black),
          ),
        ),
      );
    });
  }
}

/// ==============================
/// Screen: YachtRequestFormScreen
/// ==============================
class YachtRequestFormScreen extends StatelessWidget {
  final int id;
  YachtRequestFormScreen({super.key, required this.id});

  final controller = Get.put(YachtFormController());

  final List<String> size = const ['Big', 'Medium', 'Small'];
  final List<String> time = const ['2 hours', '3 hours', '4 hours', '5 hours+'];

  // Text controllers
  final TextEditingController peopleCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'Yacht'),
                const SizedBox(height: 8),

                // Size of Yacht
                Text('Size of Yacht', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: size,
                  hint: 'Yacht type',
                  selected: controller.yachtSize,
                  onChanged: (v) => controller.yachtSize.value = v,
                ),
                const SizedBox(height: 16),

                // Time & duration
                Text('Duration', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: time,
                  hint: 'Select duration for booking yacht',
                  selected: controller.duration,
                  onChanged: (v) => controller.duration.value = v,
                ),
                const SizedBox(height: 16),

                // Dates
                Text('Date', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _DateField(
                        label: 'From',
                        valueRx: controller.fromDate,
                        onChanged: (d) => controller.fromDate.value = d,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DateField(
                        label: 'To',
                        valueRx: controller.toDate,
                        onChanged: (d) => controller.toDate.value = d,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Number of People
                Text('Number of People', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: peopleCtrl,
                    onChanged: (v) => controller.people.value = v,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Please enter here how many people are going',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

                // Contacts
                Text('Contacts', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: contactCtrl,
                    onChanged: (v) => controller.contact.value = v,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back<void>(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColors.lightLaserColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Ensure sync if onChanged didn’t fire
                            controller.people.value = peopleCtrl.text.trim();
                            controller.contact.value = contactCtrl.text.trim();

                            await controller.submitForm(id: id);

                            // success handled inside submitForm
                          } catch (e) {
                            Get.snackbar(
                              'Failed',
                              e.toString().replaceFirst('Exception: ', ''),
                              backgroundColor: Colors.red.withOpacity(.08),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Request'),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_circle_right_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
