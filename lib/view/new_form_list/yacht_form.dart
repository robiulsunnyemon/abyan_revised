import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/style/app_text_styles.dart';
import '../../utils/style/appColor.dart';

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

  Map<String, dynamic> toJson() {
    return {
      "yachtSize": yachtSize.value,
      "duration": duration.value,
      "fromDate": fromDate.value?.toIso8601String(),
      "toDate": toDate.value?.toIso8601String(),
      "people": peopleCount,
      "contact": contact.value.trim(),
    };
  }

  Future<http.Response> submit({
    required Uri endpoint,
    Map<String, String>? extraHeaders,
  }) async {
    final err = validate();
    if (err != null) throw Exception(err);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': authToken!,
      ...?extraHeaders,
    };

    final resp = await http.post(
      endpoint,
      headers: headers,
      body: jsonEncode(toJson()),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) return resp;
    throw Exception('Failed to submit. [${resp.statusCode}] ${resp.body}');
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
  YachtRequestFormScreen({super.key});

  final controller = Get.put(YachtFormController());

  final List<String> size = const ['Big', 'Medium', 'Small'];
  final List<String> time = const ['2 hours', '3 hours', '4 hours', '5 hours+'];

  // Text controllers
  final TextEditingController peopleCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/yacht/request'; // <-- replace

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
                Text('Time & duration', style: AppTextStyle.bold16),
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
                            // Ensure sync (যদি onChanged না হয়ে থাকে)
                            controller.people.value = peopleCtrl.text;
                            controller.contact.value = contactCtrl.text;

                            final uri = Uri.parse(API_ENDPOINT);
                            await controller.submit(endpoint: uri);

                            Get.to(() => const OrderPlaceScreen());
                            Get.snackbar(
                              'Success',
                              'Your request has been submitted.',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                            );
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
