import 'package:abyansf_asfmanagment_app/api_services/form_api_services/form_api_services.dart';
import 'package:abyansf_asfmanagment_app/view/widget/cancel_button.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_text_editing_form_field_with_suffix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_text_editing_form_field.dart';
import '../../widget/custom_text_form_field_date.dart';
import '../../widget/request_button.dart';
import '../../widget/select_counter_card.dart';

class SuperCarScreen extends StatefulWidget {
  final int subCategoryId;
  const SuperCarScreen({super.key, required this.subCategoryId});

  @override
  State<SuperCarScreen> createState() => _SuperCarScreenState();
}

class _SuperCarScreenState extends State<SuperCarScreen> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController numberOfPeopleController = TextEditingController();
  final TextEditingController destinationToController = TextEditingController(text: "Dubai");
  final TextEditingController carTypeController =
  TextEditingController();

  final TextEditingController contactController = TextEditingController();


  String checkInDate = "01/01/2026";
  late DateTime checkInDateController;
  String checkOutDate = "01/02/2026";
  late DateTime checkOutDateController;

  int adultNumber=0;
  int childrenNumber=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: const CustomAppBar(title: 'Super car'),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormFieldWithSuffix(
                  controller: carTypeController,
                  onTap: () {},
                  headingText:"Car type",
                  hintText: "select car model",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomTextEditingFormFieldWithSuffix(
                  controller: destinationToController,
                  onTap: () {},
                  headingText: "Time & Duration",
                  hintText: "Select duration for booking car",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 5,
                  children: [
                    Expanded(
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
                        levelText: "Start",
                      ),
                    ),
                    Expanded(
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
                        levelText: "Return",
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
                      spacing: 5,
                      children: [
                        Expanded(
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
                        Expanded(
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: CancelButton(
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    Expanded(
                      child: RequestButton(
                        onTap: () async {
                          // // Validation Logic
                          // if (tripTypeController.text.isEmpty ||
                          //     destinationController.text.isEmpty ||
                          //     destinationToController.text.isEmpty||
                          //     checkInDate.isEmpty ||
                          //     checkOutDate.isEmpty ||
                          //     contactController.text.isEmpty
                          //     ) {
                          //   // GetX Snackbar show
                          //   Get.snackbar(
                          //     "Validation Error",
                          //     "Please fill all required fields before sending request",
                          //     snackPosition: SnackPosition.BOTTOM,
                          //     backgroundColor: Colors.red.withOpacity(0.8),
                          //     colorText: Colors.white,
                          //     margin: const EdgeInsets.all(10),
                          //     borderRadius: 8,
                          //   );
                          //   return; // Stop request
                          // }
                          //
                          // // ✅ If validation passed then request যাবে
                          // print("onTap");
                          // print(destinationController.text);
                          // print(tripTypeController.text);
                          // print(checkInDate);
                          // print(checkOutDate);
                          // print(contactController.text);
                          // print(widget.subCategoryId);
                          //
                          // Get.snackbar(
                          //   "Success",
                          //   "Request sent successfully!",
                          //   snackPosition: SnackPosition.BOTTOM,
                          //   backgroundColor: Colors.green.withValues(alpha: 0.8),
                          //   colorText: Colors.white,
                          //   margin: const EdgeInsets.all(10),
                          //   borderRadius: 8,
                          // );
                          //
                          // Map<String,dynamic> hotelAndVillasData={
                          //   "subCategoryId": widget.subCategoryId,
                          //   "typeOfAccommodation": tripTypeController.text,
                          //   "location": {
                          //     "from": destinationFromController.text,
                          //   },
                          //   "nameOfHotel": hotelNameController.text,
                          //   "checkInDate": checkInDateController.toString(),
                          //   "checkOutDate": checkOutDateController.toString(),
                          //   "guests": {
                          //     "adults": adultNumber,
                          //     "children": childrenNumber
                          //   },
                          //   "contact": contactController.text
                          //
                          // };
                          //
                          // final response=await FormRequestApiServices.formRequest(
                          //     data: hotelAndVillasData,
                          //     url: "sub-category-bookings"
                          // );
                          // if(response.statusCode==201){
                          //   Get.to(()=>CustomBottomBar());
                          // }
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
