// super_car_screen_full.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;

import '../../utils/style/appColor.dart';
import '../../utils/style/app_text_styles.dart';
import '../screens/all_form_pages/order_place_screen.dart';
import '../widget/custom_app_bar.dart';



/// -----------------------------------------
/// GetX Controller: Counter
/// -----------------------------------------
class CounterController extends GetxController {
  final RxInt count = 1.obs; // Adults default 1 to ensure >=1
  void increase() => count.value++;
  void decrease() {
    if (count.value > 0) count.value--;
  }
}

/// -----------------------------------------
/// GetX Controller: Booking Form
/// -----------------------------------------
class BookingFormController extends GetxController {
  // Dropdown selections
  final RxnString brand = RxnString();     // e.g., 'Audi'
  final RxnString timeSlot = RxnString();  // e.g., '9am-12pm'

  // Dates
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();

  // Contact
  final RxString contact = ''.obs;

  // (Optional) Auth token/header
  String? authToken;

  Map<String, dynamic> toJson({
    required int adults,
    required int children,
  }) {
    return {
      "brand": brand.value,
      "timeSlot": timeSlot.value,
      "startDate": startDate.value?.toIso8601String(),
      "endDate": endDate.value?.toIso8601String(),
      "adults": adults,
      "children": children,
      "contact": contact.value.trim(),
    };
  }

  String? validate({
    required int adults,
    required int children,
  }) {
    if (brand.value == null) return "Please select a car brand.";
    if (timeSlot.value == null) return "Please select a time slot.";
    if (startDate.value == null) return "Please pick a start date.";
    if (endDate.value == null) return "Please pick an end date.";
    if (startDate.value!.isAfter(endDate.value!)) {
      return "End date must be after start date.";
    }
    if (adults <= 0) return "Adults must be at least 1.";
    if (contact.value.trim().isEmpty) return "Please enter a WhatsApp number.";
    return null;
  }

  Future<http.Response> submitBooking({
    required Uri endpoint,
    required int adults,
    required int children,
    Map<String, String>? extraHeaders,
  }) async {
    final error = validate(adults: adults, children: children);
    if (error != null) {
      throw Exception(error);
    }

    final payload = toJson(adults: adults, children: children);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': authToken!,
      ...?extraHeaders,
    };

    final resp = await http.post(
      endpoint,
      headers: headers,
      body: jsonEncode(payload),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      return resp;
    } else {
      throw Exception('Failed to submit. [${resp.statusCode}] ${resp.body}');
    }
  }
}

/// -----------------------------------------
/// Bindable Dropdown (duplicate-safe)
/// -----------------------------------------
class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final RxnString selected;               // external Rx value
  final void Function(String?) onChanged; // setter

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueItems = (items
        .where((e) => e.trim().isNotEmpty)
        .map((e) => e.trim())
        .toSet()
        .toList())
      ..sort();

    return Obx(() {
      final String? current = selected.value;
      final String? safeValue =
      (current != null && uniqueItems.contains(current)) ? current : null;

      return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(hint),
          value: safeValue,
          items: uniqueItems
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
              .toList(),
          onChanged: onChanged,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 48,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 240,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      );
    });
  }
}

/// -----------------------------------------
/// Simple date field with showDatePicker
/// -----------------------------------------
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
      final date = valueRx.value;
      final text = (date == null)
          ? label
          : "${date.day.toString().padLeft(2, '0')}-"
          "${date.month.toString().padLeft(2, '0')}-"
          "${date.year}";

      return InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? now,
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
              color: valueRx.value == null ? Colors.grey : Colors.black,
            ),
          ),
        ),
      );
    });
  }
}

/// -----------------------------------------
/// Increase/Decrease Widget (using Icons)
/// -----------------------------------------
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

/// -----------------------------------------
/// MAIN SCREEN
/// -----------------------------------------
class SuperCarScreen extends StatelessWidget {
  SuperCarScreen({super.key});

  final booking = Get.put(BookingFormController());

  /// ইউনিক brand list
  final List<String> type = const [
    'Audi',
    'Bentley',
    'BMW',
    'Cadillac',
    'Ferrari',
    'Lamborghini',
    'Rolls Royce',
    'Porsche',
    'Mercedes',
    'Land Rover',
    'McLaren',
    'GMC',
    'Maserati',
    'Other',
  ];

  /// টাইম স্লট
  final List<String> time = const [
    '9am-12pm',
    '12pm-3pm',
    '3pm-6pm',
    '6pm-9pm',
  ];

  // কাউন্টার কন্ট্রোলার
  final adultController = Get.put(CounterController(), tag: 'super_adults');
  final childrenController = Get.put(CounterController(), tag: 'super_children');

  // কনট্যাক্ট ফিল্ড কন্ট্রোলার
  final TextEditingController phoneCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/bookings'; // <-- replace

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
                const CustomAppBar(title: 'Super car'),
                const SizedBox(height: 10),

                /// Car Brand
                Text('Car Brand:', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightLaserColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomDropdown(
                    items: type,
                    hint: 'Select car model',
                    selected: booking.brand,
                    onChanged: (v) => booking.brand.value = v,
                  ),
                ),
                const SizedBox(height: 16),

                /// Time & duration
                Text('Time & duration', style: AppTextStyle.bold16),
                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightLaserColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomDropdown(
                    items: time,
                    hint: 'Select duration for booking Car',
                    selected: booking.timeSlot,
                    onChanged: (v) => booking.timeSlot.value = v,
                  ),
                ),
                const SizedBox(height: 16),

                /// Date
                Text('Date', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _DateField(
                        label: 'Start',
                        valueRx: booking.startDate,
                        onChanged: (d) => booking.startDate.value = d,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DateField(
                        label: 'End',
                        valueRx: booking.endDate,
                        onChanged: (d) => booking.endDate.value = d,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// Guests
                Text('Number of guest', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
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

                /// Contact
                Text('Contacts', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    onChanged: (v) => booking.contact.value = v,
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightLaserColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightLaserColor,
                          width: 1.2,
                        ),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

                /// Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back<void>(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: Colors.black,
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
                            // Ensure contact sync
                            booking.contact.value = phoneCtrl.text;

                            final adults = adultController.count.value;
                            final children = childrenController.count.value;

                            final uri = Uri.parse(API_ENDPOINT);

                            await booking.submitBooking(
                              endpoint: uri,
                              adults: adults,
                              children: children,
                            );

                            // Success → navigate
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
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
