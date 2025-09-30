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
/// GetX Controller: Dining Form
/// ==============================
class DiningFormController extends GetxController {
  // Dropdown / inputs
  final RxnString venue = RxnString(); // Ac | NonAc | Premium
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
  final RxString contact = ''.obs;

  // Date & Time
  final Rxn<DateTime> reservationDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> reservationTime = Rxn<TimeOfDay>();

  // (Optional) auth token/header
  String? authToken;

  String? validate({required int adults, required int children}) {
    if (venue.value == null) return "Please select a venue.";
    if (fullName.value.trim().isEmpty) return "Please enter your full name.";
    if (email.value.trim().isEmpty) return "Please enter your email.";
    if (!email.value.contains('@')) return "Please enter a valid email.";
    if (contact.value.trim().isEmpty) return "Please enter WhatsApp number.";
    if (reservationDate.value == null) return "Please select reservation date.";
    if (reservationTime.value == null) return "Please select time.";
    if (adults <= 0) return "Adults must be at least 1.";
    return null;
  }

  Map<String, dynamic> toJson({
    required int adults,
    required int children,
  }) {
    return {
      "venue": venue.value,
      "fullName": fullName.value.trim(),
      "email": email.value.trim(),
      "contact": contact.value.trim(),
      "reservationDate": reservationDate.value?.toIso8601String(),
      "reservationTime": reservationTime.value == null
          ? null
          : "${reservationTime.value!.hour.toString().padLeft(2, '0')}:${reservationTime.value!.minute.toString().padLeft(2, '0')}",
      "adults": adults,
      "children": children,
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
            style:TextStyle(color: AppColors.white),
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
/// Local Date & Time pickers
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

class _TimeField extends StatelessWidget {
  final String label;
  final Rxn<TimeOfDay> valueRx;
  final ValueChanged<TimeOfDay> onChanged;

  const _TimeField({
    required this.label,
    required this.valueRx,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final t = valueRx.value;
      final text = (t == null)
          ? label
          : "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
      return InkWell(
        onTap: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: t ?? TimeOfDay.now(),
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
            style: TextStyle(color: t == null ? Colors.grey : Colors.black),
          ),
        ),
      );
    });
  }
}

/// ==============================
/// Screen: DiningForm
/// ==============================
class DiningForm extends StatelessWidget {
  DiningForm({super.key});

  final form = Get.put(DiningFormController());

  final List<String> type = const ['Ac', 'NonAc', 'Premium'];

  // Counters (existing IncreaseAndDecrease expects CounterController with .count)
  final adultController = Get.put(CounterController(), tag: 'life_adults');
  final childrenController = Get.put(CounterController(), tag: 'life_children');

  // Text controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/dining/request'; // <-- replace

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'Dining'),
                const SizedBox(height: 20),

                // Venue
                Text('Choose Venue', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                _BindableDropdown(
                  items: type,
                  hint: 'Select your Venue',
                  selected: form.venue,
                  onChanged: (v) => form.venue.value = v,
                ),
                const SizedBox(height: 16),

                // Name
                Text('Name', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: nameCtrl,
                    onChanged: (v) => form.fullName.value = v,
                    style:TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
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

                // Email
                Text('Email', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: emailCtrl,
                    onChanged: (v) => form.email.value = v,
                    style:TextStyle(color: AppColors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
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
                    style:TextStyle(color: AppColors.white),
                    onChanged: (v) => form.contact.value = v,
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

                // Date & Time
                Text('Date of reservation', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: _DateField(
                      label: 'Select date',
                      valueRx: form.reservationDate,
                      onChanged: (d) => form.reservationDate.value = d,
                    ),
                  )
                ]),
                const SizedBox(height: 16),
                Text('Time', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: _TimeField(
                      label: 'Select time',
                      valueRx: form.reservationTime,
                      onChanged: (t) => form.reservationTime.value = t,
                    ),
                  )
                ]),
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
                            // ensure sync
                            form.fullName.value = nameCtrl.text;
                            form.email.value = emailCtrl.text;
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
                      color: AppColors.white
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