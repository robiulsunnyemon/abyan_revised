import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../view_models/controller/counter_controller.dart';
import '../../utils/style/appColor.dart';
import '../widget/increase_and_decrease.dart';

/// ==============================
/// Form Controller (GetX)
/// ==============================
class HotelVillasFormController extends GetxController {
  // dropdowns
  final RxnString accommodationType = RxnString(); // Ac | NonAc | Premium
  final RxnString hotelName = RxnString();         // যেটা select করবে

  // text fields
  final RxString location = ''.obs;
  final RxString contact = ''.obs;

  // dates
  final Rxn<DateTime> checkIn = Rxn<DateTime>();
  final Rxn<DateTime> checkOut = Rxn<DateTime>();

  // optional auth
  String? authToken;

  Map<String, dynamic> toJson({
    required int adults,
    required int children,
  }) {
    return {
      "accommodationType": accommodationType.value,
      "location": location.value.trim(),
      "hotelName": hotelName.value,
      "checkIn": checkIn.value?.toIso8601String(),
      "checkOut": checkOut.value?.toIso8601String(),
      "adults": adults,
      "children": children,
      "contact": contact.value.trim(),
    };
  }

  String? validate({
    required int adults,
    required int children,
  }) {
    if (accommodationType.value == null) return "Please select accommodation type.";
    if (location.value.trim().isEmpty) return "Please enter location.";
    if (hotelName.value == null) return "Please select a hotel.";
    if (checkIn.value == null) return "Please select check-in date.";
    if (checkOut.value == null) return "Please select check-out date.";
    if (!checkOut.value!.isAfter(checkIn.value!)) return "Check-out must be after check-in.";
    if (adults <= 0) return "Adults must be at least 1.";
    if (contact.value.trim().isEmpty) return "Please enter WhatsApp number.";
    return null;
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

    final resp = await http.post(
      endpoint,
      headers: headers,
      body: jsonEncode(toJson(adults: adults, children: children)),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) return resp;
    throw Exception('Failed to submit. [${resp.statusCode}] ${resp.body}');
  }
}

/// ==============================
/// Screen
/// ==============================
class HotelAndVillasScreen extends StatelessWidget {
  HotelAndVillasScreen({super.key});

  final form = Get.put(HotelVillasFormController());

  // sample data
  final List<String> accommodationTypes = const ['Ac', 'NonAc', 'Premium'];
  final List<String> hotelNames = const [
    'Hotel Sunrise',
    'Blue Lagoon Resort',
    'Palm Vista Villas',
    'Royal Crown',
    'Premium Stay'
  ];

  // counters
  final adultController = Get.put(CounterController(), tag: 'hotel_adults');
  final childrenController = Get.put(CounterController(), tag: 'hotel_children');

  // text controllers
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/hotel-villas/request'; // <-- replace

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'Hotel & Villas'),
                const SizedBox(height: 8),

                // Accommodation type
                Text('Type of accommodation', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: accommodationTypes,
                  hint: 'Select accommodation',
                  selected: form.accommodationType,
                  onChanged: (v) => form.accommodationType.value = v,
                ),
                const SizedBox(height: 16),

                // Location
                Text('Location', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: locationCtrl,
                    onChanged: (v) => form.location.value = v,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      hintText: 'Address',
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

                // Hotel name
                Text('Name of hotel', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: hotelNames,
                  hint: 'Name of hotel',
                  selected: form.hotelName,
                  onChanged: (v) => form.hotelName.value = v,
                ),
                const SizedBox(height: 16),

                // Dates
                Text('Date', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _DateField(
                        label: 'Check in',
                        valueRx: form.checkIn,
                        onChanged: (d) => form.checkIn.value = d,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DateField(
                        label: 'Check out',
                        valueRx: form.checkOut,
                        onChanged: (d) => form.checkOut.value = d,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Guests
                Text('Number of guest', style: AppTextStyle.bold16),
                Row(
                  children: [
                    IncreaseAndDecrease(
                      type: 'Adults',
                      counter: adultController,
                    ),
                    const SizedBox(width: 10),
                    IncreaseAndDecrease(
                      type: 'Children',
                      counter: childrenController,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Contact
                Text('Contacts', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: contactCtrl,
                    onChanged: (v) => form.contact.value = v,
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

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
                            // sync text (যদি onChanged না চলে থাকে)
                            form.location.value = locationCtrl.text;
                            form.contact.value = contactCtrl.text;

                            final adults = adultController.count.value;
                            final children = childrenController.count.value;

                            final uri = Uri.parse(API_ENDPOINT);
                            await form.submit(
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
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
/// Local date field (showDatePicker)
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
            style: TextStyle(
              color: d == null ? Colors.grey : Colors.black,
            ),
          ),
        ),
      );
    });
  }
}


class CounterController extends GetxController {
  final RxInt count = 1.obs; // Adults default 1 to ensure >=1
  void increase() => count.value++;
  void decrease() {
    if (count.value > 0) count.value--;
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