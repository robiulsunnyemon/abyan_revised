import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/style/app_text_styles.dart';
import '../../utils/style/appColor.dart';
import '../widget/increase_and_decrease.dart';

/// ==============================
/// GetX Controller: Beach Club Form
/// ==============================
class BeachClubFormController extends GetxController {
  // Dropdown: Venue type
  final RxnString venue = RxnString(); // 'Ac' | 'NonAc' | 'Premium'

  // Inputs
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
  final RxString contact = ''.obs;

  // Date & Time
  final Rxn<DateTime> reservationDate = Rxn<DateTime>();
  final Rxn<TimeOfDay> reservationTime = Rxn<TimeOfDay>();

  // (Optional) auth token/header
  String? authToken;

  Map<String, dynamic> toJson({
    required int adults,
    required int children,
  }) {
    return {
      "venue": venue.value, // Ac/NonAc/Premium
      "fullName": fullName.value.trim(),
      "email": email.value.trim(),
      "contact": contact.value.trim(),
      "reservationDate": reservationDate.value?.toIso8601String(),
      "reservationTime": reservationTime.value == null
          ? null
          : _formatTime(reservationTime.value!),
      "adults": adults,
      "children": children,
    };
  }

  String? validate({
    required int adults,
    required int children,
  }) {
    if (venue.value == null) return "Please select a venue.";
    if (fullName.value.trim().isEmpty) return "Please enter your full name.";
    if (email.value.trim().isEmpty) return "Please enter your email.";
    // খুব কড়া ভ্যালিডেশন নয়, মিনিমাল চেক:
    if (!email.value.contains('@')) return "Please enter a valid email.";
    if (contact.value.trim().isEmpty) return "Please enter WhatsApp number.";
    if (reservationDate.value == null) return "Please select reservation date.";
    if (reservationTime.value == null) return "Please select time.";
    if (adults <= 0) return "Adults must be at least 1.";
    return null;
  }

  Future<http.Response> submit({
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

  static String _formatTime(TimeOfDay t) {
    final hh = t.hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}

/// ==============================
/// UI Screen: BeachClubForm
/// ==============================
class BeachClubForm extends StatelessWidget {
  BeachClubForm({super.key});

  // Controller bind
  final form = Get.put(BeachClubFormController());

  final List<String> type = const ['Ac', 'NonAc', 'Premium'];

  // Counters
  final adultController = Get.put(CounterController(), tag: 'super_adults');
  final childrenController = Get.put(CounterController(), tag: 'super_children');

  // Text controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  static const String API_ENDPOINT = 'https://api.example.com/beach-club/request'; // <-- replace

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
                const CustomAppBar(title: 'Beach club'),
                const SizedBox(height: 20),

                // Venue
                Text('Choose Venue', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                // Expecting bindable CustomDropdown (items/hint/selected/onChanged)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightLaserColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomDropdown(
                    items: type,
                    hint: 'Select your Venue',
                    selected: form.venue,
                    onChanged: (v) => form.venue.value = v,
                  ),
                ),

                const SizedBox(height: 16),

                // Name
                Text('Name', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: nameCtrl,
                    onChanged: (v) => form.fullName.value = v,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightLaserColor, width: 1.2),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

                // WhatsApp
                Text('Contacts', style: AppTextStyle.bold16),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 16),
                  child: TextFormField(
                    controller: phoneCtrl,
                    onChanged: (v) => form.contact.value = v,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightLaserColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightLaserColor, width: 1.2),
                      ),
                      fillColor: AppColors.white,
                    ),
                  ),
                ),

                // Date
                Text('Date of reservation', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      // তুমি চাইলে তোমার CustomDatePicker-এ onDateSelected যোগ করে ব্যবহার করবে
                      child: _DateField(
                        label: 'Select date',
                        valueRx: form.reservationDate,
                        onChanged: (d) => form.reservationDate.value = d,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Time
                Text('Time', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _TimeField(
                        label: 'Select time',
                        valueRx: form.reservationTime,
                        onChanged: (t) => form.reservationTime.value = t,
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
                const SizedBox(height: 20),

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
                            // sync text to controller (যদি কিবোর্ড বন্ধ থাকায় onChanged না চলে)
                            form.fullName.value = nameCtrl.text;
                            form.email.value = emailCtrl.text;
                            form.contact.value = phoneCtrl.text;

                           // final adults = adultController.count.value;
                           // final children = childrenController.count.value;

                            final uri = Uri.parse(API_ENDPOINT);
                           // await form.submit(
                            //  endpoint: uri,
                            //  adults: adults,
                             // children: children,
                            //);

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

/// ==============================
/// Simple Date picker field (local)
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

/// ==============================
/// Simple Time picker field (local)
/// ==============================
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
          : '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
      return InkWell(
        onTap: () async {
          final now = TimeOfDay.now();
          final picked = await showTimePicker(
            context: context,
            initialTime: t ?? now,
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