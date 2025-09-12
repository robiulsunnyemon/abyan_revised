import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/style/app_text_styles.dart';
import '../../../view_models/controller/counter_controller.dart';
import '../../utils/style/appColor.dart';
import '../widget/increase_and_decrease.dart';

/// ==============================
/// GetX Controller: Jets form
/// ==============================
class JetsFormController extends GetxController {
  // Travel type: One-way | Round trip
  final RxnString travelType = RxnString();

  // From / To
  final RxnString fromCity = RxnString();
  final RxnString toCity = RxnString();

  // Dates
  final Rxn<DateTime> departDate = Rxn<DateTime>();
  final Rxn<DateTime> returnDate = Rxn<DateTime>();

  // Contact
  final RxString contact = ''.obs;

  // (Optional) Auth header
  String? authToken;

  bool get isRoundTrip => travelType.value == 'Round trip';

  String? validate({required int adults, required int children}) {
    if (travelType.value == null) return "Please select travel type.";
    if (fromCity.value == null) return "Please select origin.";
    if (toCity.value == null) return "Please select destination.";
    if (fromCity.value == toCity.value) return "Origin and destination must differ.";
    if (departDate.value == null) return "Please select departure date.";
    if (isRoundTrip) {
      if (returnDate.value == null) return "Please select return date.";
      if (!returnDate.value!.isAfter(departDate.value!)) {
        return "Return date must be after departure date.";
      }
    }
    if (adults <= 0) return "Adults must be at least 1.";
    if (contact.value.trim().isEmpty) return "Please enter WhatsApp number.";
    return null;
  }

  Map<String, dynamic> toJson({
    required int adults,
    required int children,
  }) {
    return {
      "travelType": travelType.value,
      "from": fromCity.value,
      "to": toCity.value,
      "departDate": departDate.value?.toIso8601String(),
      "returnDate": returnDate.value?.toIso8601String(),
      "adults": adults,
      "children": children,
      "contact": contact.value.trim(),
    };
  }

  Future<http.Response> submit({
    required Uri endpoint,
    required int adults,
    required int children,
    Map<String, String>? extraHeaders,
  }) async {
    final err = validate(adults: adults, children: children);
    if (err != null) throw Exception(err);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': authToken!,
      ...?extraHeaders,
    };

    final payload = toJson(adults: adults, children: children);

    final resp = await http.post(endpoint, headers: headers, body: jsonEncode(payload));
    if (resp.statusCode >= 200 && resp.statusCode < 300) return resp;

    throw Exception('Failed to submit. [${resp.statusCode}] ${resp.body}');
  }
}

/// ==============================
/// Local dropdown (duplicate-safe, bindable)
/// ==============================
class _BindableDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final RxnString selected;
  final void Function(String?) onChanged;
  final String? label;

  const _BindableDropdown({
    required this.items,
    required this.hint,
    required this.selected,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final unique = (items.where((e) => e.trim().isNotEmpty).map((e) => e.trim()).toSet().toList())
      ..sort();

    return Obx(() {
      final current = selected.value;
      final safeValue = (current != null && unique.contains(current)) ? current : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(label!, style: AppTextStyle.bold16),
            const SizedBox(height: 6),
          ],
          DropdownButtonHideUnderline(
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
                items: unique.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
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
          : "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";

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
/// Screen
/// ==============================
class JetsScreen extends StatelessWidget {
  JetsScreen({super.key});

  final controller = Get.put(JetsFormController());

  final List<String> trip = const ['One-way', 'Round trip'];
  final List<String> cities = const [
    'Dubai (DXB)',
    'Abu Dhabi (AUH)',
    'Doha (DOH)',
    'Jeddah (JED)',
    'Riyadh (RUH)',
    'Muscat (MCT)',
    'Kuwait (KWI)',
  ];

  // Counters
  final adultController = Get.put(CounterController(), tag: 'jets_adults');
  final childrenController = Get.put(CounterController(), tag: 'jets_children');

  // Contact
  final TextEditingController contactCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/jets/request'; // <-- replace

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
                const CustomAppBar(title: 'Jets'),
                const SizedBox(height: 8),

                // Travel type
                Text('Travel Type:', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: trip,
                  hint: 'Round/One-way trip',
                  selected: controller.travelType,
                  onChanged: (v) => controller.travelType.value = v,
                ),
                const SizedBox(height: 16),

                // From / To
                Text('Destination', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _BindableDropdown(
                        items: cities,
                        hint: 'Start Point',
                        selected: controller.fromCity,
                        onChanged: (v) => controller.fromCity.value = v,
                        label: 'From',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _BindableDropdown(
                        items: cities,
                        hint: 'Destination',
                        selected: controller.toCity,
                        onChanged: (v) => controller.toCity.value = v,
                        label: 'To',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Dates
                Text('Dates', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Obx(() {
                  final isRound = controller.isRoundTrip;
                  return Row(
                    children: [
                      Expanded(
                        child: _DateField(
                          label: 'Departure',
                          valueRx: controller.departDate,
                          onChanged: (d) => controller.departDate.value = d,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: IgnorePointer(
                          ignoring: !isRound,
                          child: Opacity(
                            opacity: isRound ? 1 : 0.5,
                            child: _DateField(
                              label: 'Return',
                              valueRx: controller.returnDate,
                              onChanged: (d) => controller.returnDate.value = d,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),

                // Guests
                Text('Number of guest', style: AppTextStyle.bold16),
                Row(
                  children: [
                    IncreaseAndDecrease(type: 'Adults', counter: adultController),
                    const SizedBox(width: 10),
                    IncreaseAndDecrease(type: 'Children', counter: childrenController),
                  ],
                ),
                const SizedBox(height: 16),

                // Contact
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
                            // Ensure contact synced
                            controller.contact.value = contactCtrl.text;

                            final adults = adultController.count.value;
                            final children = childrenController.count.value;

                            final uri = Uri.parse(API_ENDPOINT);
                            await controller.submit(
                              endpoint: uri,
                              adults: adults,
                              children: children,
                            );

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



class IncreaseAndDecrease extends StatelessWidget {
  final String type;
  final CounterController counter;

  const IncreaseAndDecrease({
    super.key,
    required this.type,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightLaserColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: AppColors.lightLaserColor,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: counter.decrease,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.remove_circle_outline,color: AppColors.lightLaserColor),

                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() => Text(
                    counter.count.value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: counter.increase,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.add_circle_outline,color: AppColors.lightLaserColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CounterController extends GetxController {
  final RxInt count = 1.obs; // Adults default 1 to ensure >=1
  void increase() => count.value++;
  void decrease() {
    if (count.value > 0) count.value--;
  }
}