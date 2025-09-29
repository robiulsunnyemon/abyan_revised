import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/screens/all_form_pages/order_place_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/style/app_text_styles.dart';
import '../../../view_models/controller/counter_controller.dart';
import '../../api_services/form_api_services/form_api_services.dart';
import '../../utils/style/appColor.dart';
import '../widget/custom_bottom_bar.dart';

/// Helpers: safely unwrap Rx/DateTime and clean Maps/Lists for JSON
/// ---------------------------------------------------------------------------
dynamic _deepUnwrap(dynamic v) {
  if (v is Rx) return _deepUnwrap(v.value); // Rx/Rxn → value
  if (v is DateTime) return v.toIso8601String(); // DateTime → ISO
  if (v is Map)
    return v.map((k, val) => MapEntry(k.toString(), _deepUnwrap(val)));
  if (v is List) return v.map(_deepUnwrap).toList();
  return v; // primitive
}

Map<String, dynamic> _removeNulls(Map<String, dynamic> m) {
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    if (v != null) out[k] = v;
  });
  return out;
}

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
    if (fromCity.value == toCity.value)
      return "Origin and destination must differ.";
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

  Future<void> submitForm({
    required int id,
    required int adult,
    required int children,
  }) async {
    // Validate first
    final err = validate(adults: adult, children: children);
    if (err != null) {
      Get.snackbar(
        'Validation failed',
        err,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // IMPORTANT: Send only ONE of subCategoryId / miniSubCategoryId
    final idBlock = {
      "miniSubCategoryId":
          id, // <-- if API needs subCategoryId instead, change key here
      // "subCategoryId": id,        // (and remove miniSubCategoryId)
    };

    // Build raw payload (Rx/DateTime allowed; deepUnwrap will clean)
    final raw = <String, dynamic>{
      ...idBlock,
      // Use backend field names expected by your API
      "typeOfAccommodation":
          travelType.value, // or "travelType" if API expects that
      "location": {"from": fromCity.value, "to": toCity.value},
      "checkInDate": departDate.value, // DateTime?
      "checkOutDate": isRoundTrip ? returnDate.value : null, // One-way => null
      "guests": {"adults": adult, "children": children},
      "contact": contact.value.trim(),
    };

    // Convert Rx/DateTime → primitives and drop nulls
    final payload = _removeNulls(_deepUnwrap(raw) as Map<String, dynamic>);

    try {
      // Debug: see final request body
      // ignore: avoid_print
      print('REQUEST BODY => $payload');

      final response = await FormRequestApiServices.formRequest(
        data: payload,
        url: "sub-category-bookings",
        // headers: {
        //   "Content-Type": "application/json",
        //   if (authToken != null) "Authorization": "Bearer $authToken",
        // },
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Your request has been submitted.',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.to(() => const OrderPlaceScreen());
        // Or: Get.to(() => const OrderPlaceScreen());
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
    final unique =
        (items
              .where((e) => e.trim().isNotEmpty)
              .map((e) => e.trim())
              .toSet()
              .toList())
          ..sort();

    return Obx(() {
      final current = selected.value;
      final safeValue = (current != null && unique.contains(current))
          ? current
          : null;

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
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                items: unique
                    .map(
                      (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                    )
                    .toList(),
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
/// Screen
/// ==============================
class JetsScreen extends StatelessWidget {
  final int id;
  JetsScreen({super.key, required this.id});

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
                Text('Travel Type', style: AppTextStyle.bold16),
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
                    _IncreaseAndDecrease(
                      type: 'Adults',
                      counter: adultController,
                    ),
                    const SizedBox(width: 10),
                    _IncreaseAndDecrease(
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
                    onChanged: (v) => controller.contact.value = v,
                    keyboardType: TextInputType.phone,
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
                            controller.contact.value = contactCtrl.text.trim();

                            final adults = adultController.count.value;
                            final children = childrenController.count.value;

                            await controller.submitForm(
                              adult: adults,
                              children: children,
                              id: id,
                            );

                            // Success handled inside submitForm
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
/// Simple Counter UI (Adults/Children)
/// ==============================
class _IncreaseAndDecrease extends StatelessWidget {
  final String type;
  final CounterController counter;

  const _IncreaseAndDecrease({
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
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.lightLaserColor,
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
                        color: AppColors.lightLaserColor,
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

class CounterController extends GetxController {
  final RxInt count = 1.obs; // Adults default 1 to ensure >=1
  void increase() => count.value++;
  void decrease() {
    if (count.value > 0) count.value--;
  }
}
