import 'package:abyansf_asfmanagment_app/api_services/form_api_services/form_api_services.dart';
import 'package:abyansf_asfmanagment_app/view/widget/cancel_button.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_text_editing_form_field_with_suffix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_text_editing_form_field.dart';
import '../../widget/custom_text_form_field_date.dart';
import '../../widget/request_button.dart';
import '../../widget/select_counter_card.dart';

class HotelAndVillasScreen extends StatefulWidget {
  final int subCategoryId;
  const HotelAndVillasScreen({super.key, required this.subCategoryId});

  @override
  State<HotelAndVillasScreen> createState() => _HotelAndVillasScreenState();
}

class _HotelAndVillasScreenState extends State<HotelAndVillasScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController typeOfAccommodationController =
      TextEditingController();
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  int adultNumber = 0;
  int childrenNumber = 0;
  String checkInDate = "01/01/2026";
  late DateTime checkInDateController;
  String checkOutDate = "01/02/2026";
  late DateTime checkOutDateController;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: const CustomAppBar(title: 'Hotel & Villas'),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormFieldWithSuffix(
                  controller: typeOfAccommodationController,
                  onTap: () {},
                  headingText: "Type of accommodation",
                  hintText: "Select accommodation",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormField(
                  controller: locationController,
                  headingText: "Location",
                  hintText: "Dubai",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormFieldWithSuffix(
                  controller: hotelNameController,
                  onTap: () {},
                  headingText: "Name of hotel",
                  hintText: "Name of hotel",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: CustomTextFormFieldLevel(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              checkInDateController=picked;
                              checkInDate = DateFormat('dd/MM/yyyy').format(picked);
                            });
                          }
                        },
                        headingText: "Date",
                        hintText:checkInDate,
                        levelText: "Check in",
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: CustomTextFormFieldLevel(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              checkOutDateController=picked;
                              checkOutDate = DateFormat('dd/MM/yyyy').format(picked);
                            });
                          }
                        },
                        headingText: "",
                        hintText: checkOutDate,
                        levelText: "Check out",
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of guest',
                      style: TextStyle(
                        color: const Color(0xFF1A1A1A) /* Woodsmoke-950 */,
                        fontSize: 16,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 165.w,
                          child: SelectCounterCard(
                            counterText: adultNumber.toString(),
                            hintText: "Adults",
                            decreaseOnTap: () {
                              if (adultNumber > 0) {
                                setState(() {
                                  adultNumber--;
                                });
                              }
                            },
                            increaseOnTap: () {
                              setState(() {
                                adultNumber++;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 165.w,
                          child: SelectCounterCard(
                            counterText: childrenNumber.toString(),
                            hintText: "Child",
                            decreaseOnTap: () {
                              if (childrenNumber > 0) {
                                setState(() {
                                  childrenNumber--;
                                });
                              }
                            },
                            increaseOnTap: () {
                              setState(() {
                                childrenNumber++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormField(
                  controller: contactController,
                  headingText: "Contacts",
                  hintText: "Enter your WhatsApp number",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: CancelButton(
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: RequestButton(
                        onTap: () async {
                          // Validation Logic
                          if (typeOfAccommodationController.text.isEmpty ||
                              locationController.text.isEmpty ||
                              hotelNameController.text.isEmpty ||
                              checkInDate.isEmpty ||
                              checkOutDate.isEmpty ||
                              contactController.text.isEmpty ||
                              adultNumber == 0 && childrenNumber == 0) {
                            // GetX Snackbar show
                            Get.snackbar(
                              "Validation Error",
                              "Please fill all required fields before sending request",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              borderRadius: 8,
                            );
                            return; // Stop request
                          }

                          // ✅ If validation passed then request যাবে
                          print("onTap");
                          print(locationController.text);
                          print(typeOfAccommodationController.text);
                          print(hotelNameController.text);
                          print(checkInDate);
                          print(checkOutDate);
                          print(contactController.text);
                          print(adultNumber);
                          print(childrenNumber);
                          print(widget.subCategoryId);

                          Get.snackbar(
                            "Success",
                            "Request sent successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            borderRadius: 8,
                          );

                          Map<String,dynamic> hotelAndVillasData={
                            "subCategoryId": widget.subCategoryId,
                            "typeOfAccommodation": typeOfAccommodationController.text,
                            "location": {
                              "from": locationController.text,
                            },
                            "nameOfHotel": hotelNameController.text,
                            "checkInDate": checkInDateController.toString(),
                            "checkOutDate": checkOutDateController.toString(),
                            "guests": {
                              "adults": adultNumber,
                              "children": childrenNumber
                            },
                            "contact": contactController.text

                          };

                          final response=await FormRequestApiServices.formRequest(
                              data: hotelAndVillasData,
                              url: "sub-category-bookings"
                          );
                          if(response.statusCode==201){
                            Get.to(()=>CustomBottomBar());
                          }
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
