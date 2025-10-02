import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_text_editing_form_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/style/app_text_styles.dart';
import '../../api_services/form_api_services/form_api_services.dart';
import '../../utils/style/appColor.dart';

dynamic _deepUnwrap(dynamic v) {
  // Rx types → .value
  if (v is Rx) return _deepUnwrap(v.value);

  // DateTime → ISO string
  if (v is DateTime) return v.toIso8601String();

  // TimeOfDay → "HH:mm"
  if (v is TimeOfDay) {
    final hh = v.hour.toString().padLeft(2, '0');
    final mm = v.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  // Map → recurse
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), _deepUnwrap(val)));
  }

  // List → recurse
  if (v is List) {
    return v.map(_deepUnwrap).toList();
  }

  // Primitive or already clean
  return v;
}

Map<String, dynamic> deepSanitize(Map<String, dynamic> m) =>
    _deepUnwrap(m) as Map<String, dynamic>;

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

  Map<String, dynamic> toJson({required int adults, required int children}) {
    // (toJson ইউজ করতে চাইলে ব্যবহার করুন — deepSanitize ছাড়াই ক্লিন)
    return {
      "venueName": venue.value,
      "name": fullName.value.trim(),
      "email": email.value.trim(),
      "whatsapp": contact.value.trim(),
      "bookingDate": reservationDate.value?.toIso8601String(),
      "bookingTime": reservationTime.value == null
          ? null
          : _formatTime(reservationTime.value!),
      "numberofguest_adult": adults,
      "numberofguest_child": children,
    };
  }

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

  Future<void> submitForm({
    required int id,
    required int adult,
    required int children,
  }) async {
    // client-side validation
    final err = validate(adults: adult, children: children);
    if (err != null) {
      Get.snackbar(
        'Validation failed',
        err,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Build raw payload (Rx/DateTime/TimeOfDay allowed here)
    final raw = <String, dynamic>{
      "listingId": id,
      "bookingDate": reservationDate.value,
      // DateTime? (deepSanitize ISO করবে)
      "bookingTime": reservationTime.value,
      // TimeOfDay? (deepSanitize HH:mm করবে)
      "name": fullName.value.trim(),
      "email": email.value.trim(),
      "whatsapp": contact.value.trim(),
      "venueName": venue.value,
      "numberofguest_adult": adult,
      "numberofguest_child": children,
    };

    // Convert Rx/DateTime/TimeOfDay → primitives/ISO
    final beachClubData = deepSanitize(raw);

    try {
      // Send request
      final response = await FormRequestApiServices.formRequest(
        data: beachClubData,
        url: "sub-category-bookings",
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
  final int listingId;
  final String venueName;

  BeachClubForm({super.key, required this.listingId, required this.venueName});

  // Controller bind
  final form = Get.put(BeachClubFormController());

  final List<String> type = const ['Ac', 'NonAc', 'Premium'];

  // Counters
  final adultController = Get.put(CounterController(), tag: 'super_adults');
  final childrenController = Get.put(
    CounterController(),
    tag: 'super_children',
  );
  final TextEditingController beachClubController = TextEditingController();

  // Text controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                CustomTextEditingFormField(
                  isReadOnly: true,
                  controller: beachClubController,
                  headingText: "Venue",
                  hintText: venueName,
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
                      hintStyle: TextStyle(
                        color: AppColors.hintWhiteColor,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white,
                          width: 1.2,
                        ),
                      ),
                      fillColor: Colors.transparent,
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
                    style:TextStyle(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: AppColors.hintWhiteColor,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white,
                          width: 1.2,
                        ),
                      ),
                      fillColor: Colors.transparent,
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
                    style:TextStyle(color: AppColors.white),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your WhatsApp number',
                      hintStyle: TextStyle(
                        color: AppColors.hintWhiteColor,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white,
                          width: 1.2,
                        ),
                      ),
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),

                // Date
                Text('Date of reservation', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
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
                            // sync text to controller (ensure latest values)
                            form.fullName.value = nameCtrl.text.trim();
                            form.email.value = emailCtrl.text.trim();
                            form.contact.value = phoneCtrl.text.trim();

                            final adults = adultController.count.value;
                            final children = childrenController.count.value;

                            await form.submitForm(
                              adult: adults,
                              children: children,
                              id: listingId,
                            );
                            // Success snackbar & navigation handled inside submitForm
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
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: valueRx.value == null
                  ? AppColors.hintWhiteColor
                  : AppColors.white,
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
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: valueRx.value == null ? AppColors.hintWhiteColor : AppColors.white,
            ),
          ),
        ),
      );
    });
  }
}

/// ==============================
/// Dropdown (dropdown_button2 ভিত্তিক)
/// ==============================
class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final RxnString selected;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueItems =
        (items
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
          style:TextStyle(color: AppColors.white),
          isExpanded: true,
          hint: Text(hint),
          value: safeValue,
          items: uniqueItems
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
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
              color: Colors.white,
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

/// ==============================
/// Simple Counter + UI (Adults/Children)
/// ==============================
class CounterController extends GetxController {
  final RxInt count = 0.obs; // Adults default 1 to ensure >=1
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
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: AppColors.white,
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
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.goldenTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(
                    () => Text(
                      counter.count.value.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: counter.increase,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: AppColors.goldenTextColor,
                      ),
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
