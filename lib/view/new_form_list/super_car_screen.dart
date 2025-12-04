// super_car_screen_full.dart
import 'dart:convert'; // if your service encodes, you can remove this
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:http/http.dart' as http; // remove if unused

import '../../api_services/form_api_services/form_api_services.dart';
import '../../utils/style/appColor.dart';
import '../../utils/style/app_text_styles.dart';
import '../screens/all_form_pages/order_place_screen.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_bottom_bar.dart';

/// -----------------------------------------
/// Helpers
/// -----------------------------------------
Map<String, dynamic> _removeNulls(Map<String, dynamic> m) {
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    if (v != null) out[k] = v;
  });
  return out;
}

String? _toIso(DateTime? dt) => dt?.toIso8601String();

/// -----------------------------------------
/// GetX Controller: Counter
/// -----------------------------------------
class CounterController extends GetxController {
  final RxInt count = 0.obs; // Adults default 1 to ensure >=1
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
  final RxnString brand = RxnString(); // e.g., 'Audi'
  final RxnString timeSlot = RxnString(); // e.g., '9am-12pm'

  // Dates
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();

  // Contact
  final RxString contact = ''.obs;

  // (Optional) Auth token/header
  String? authToken;

  String? validate({required int adults, required int children}) {
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

  Future<void> submitBooking({
    required int id,
    required int adults,
    required int children,
  }) async {
    // validate first
    final err = validate(adults: adults, children: children);
    if (err != null) {
      Get.snackbar(
        'Validation failed',
        err,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }

    // DateTime → ISO strings
    final String? startIso = _toIso(startDate.value);
    final String? endIso = _toIso(endDate.value);

    // IMPORTANT: Send only ONE of subCategoryId / miniSubCategoryId
    // Here we use subCategoryId. If API needs miniSubCategoryId, swap the key.
    final Map<String, dynamic> body = _removeNulls({
      "subCategoryId": id,
      // or "miniSubCategoryId": id
      "typeOfAccommodation": brand.value,
      // keep the field name your API expects
      "location": {
        "from": timeSlot.value, // String
      },
      "checkInDate": startIso,
      // String (ISO), not DateTime
      "checkOutDate": endIso,
      // String (ISO), not DateTime
      "guests": {"adults": adults, "children": children},
      "contact": contact.value.trim(),
      // String
    });

    try {
      // Debug: inspect final payload
      // ignore: avoid_print
      print('REQUEST BODY => $body');

      final response = await FormRequestApiServices.formRequest(
        data: body,
        url: "sub-category-bookings",
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Your request has been submitted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
        Get.to(() => const OrderPlaceScreen());

      } else {
        Get.snackbar(
          'Failed',
          'Server responded: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}

/// -----------------------------------------
/// Bindable Dropdown (duplicate-safe)
/// -----------------------------------------
class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final RxnString selected; // external Rx value
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
          style: TextStyle(color: AppColors.white),
          iconStyleData: IconStyleData(
            iconDisabledColor: Colors.white,
            iconEnabledColor: Colors.white,
          ),
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(
              color: AppColors.hintWhiteColor,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          value: safeValue,
          selectedItemBuilder: (BuildContext context) {
            return uniqueItems.map((e) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  e,
                  style: TextStyle(
                    color: AppColors.white, // Selected value white
                    fontSize: 14,
                  ),
                ),
              );
            }).toList();
          },
          items: uniqueItems
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(color: AppColors.blackColor),
                  ),
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
    // Screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              type,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: counter.decrease,
                    child: Icon(
                      Icons.remove_circle_outline,
                      color: AppColors.goldenTextColor,
                      size: 24.sp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4,left: 4,right: 4),
                    child: Obx(
                          () => Text(
                        counter.count.value.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: counter.increase,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: AppColors.goldenTextColor,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -----------------------------------------
/// MAIN SCREEN
/// -----------------------------------------
class SuperCarScreen extends StatelessWidget {
  final int id;

  SuperCarScreen({super.key, required this.id});

  final booking = Get.put(BookingFormController());

  /// Unique brand list
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

  /// Time slots
  final List<String> time = const [
    '1 day',
    '2 days',
    '3 days',
    '4 days',
    '5+ days',
  ];

  // Counters
  final adultController = Get.put(CounterController(), tag: 'super_adults');
  final childrenController = Get.put(
    CounterController(),
    tag: 'super_children',
  );

  // Contact field controller
  final TextEditingController phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(title: 'Super Cars'),
                const SizedBox(height: 10),

                /// Car Brand
                Text('Car Brand', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
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
                Text('Rental Period', style: AppTextStyle.bold16),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
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
                    style: TextStyle(color: AppColors.white),
                    onChanged: (v) => booking.contact.value = v,
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
                        child:  Text('Cancel',style: AppTextStyle.regular16.copyWith(color: AppColors.blackColor),),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Ensure contact sync
                            booking.contact.value = phoneCtrl.text.trim();
                            final adults = adultController.count.value;
                            final children = childrenController.count.value;
                            await booking.submitBooking(
                              adults: adults,
                              children: children,
                              id: id,
                            );
                            // Success snackbar + navigation handled inside submitBooking
                          } catch (e) {
                            Get.snackbar(
                              'Failed',
                              e.toString().replaceFirst('Exception: ', ''),
                              backgroundColor: Colors.red,
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
                          children:  [
                            Text('Request',style: AppTextStyle.regular16.copyWith(color: AppColors.blackColor),),
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
