import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../api_services/form_api_services/form_api_services.dart';
import '../../widget/cancel_button.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_bottom_bar.dart';
import '../../widget/custom_text_editing_form_field.dart';
import '../../widget/custom_text_editing_form_field_with_suffix.dart';
import '../../widget/custom_text_form_field_date.dart';
import '../../widget/request_button.dart';
import '../../widget/select_counter_card.dart';

class WellnessForm extends StatefulWidget {
  final String venueName;
  final int listingId;
  const WellnessForm({super.key, required this.venueName, required this.listingId});

  @override
  State<WellnessForm> createState() => _WellnessFormState();
}

class _WellnessFormState extends State<WellnessForm> {


  final TextEditingController venueController = TextEditingController();
  final TextEditingController typeOfServicesController = TextEditingController(text: "SPA");
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateOfPreController = TextEditingController();


  int adultNumber = 0;
  int childrenNumber = 0;
  String checkInDate = "01/01/2026";
  late DateTime checkInDateController;
  String checkOutDate = "01/02/2026";
  late DateTime checkOutDateController;
  String selectedTime = "9:45";


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: const CustomAppBar(title: 'Wellness'),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormField(
                  isReadOnly: true,
                  controller: venueController,
                  headingText: "Choose Venue",
                  hintText: widget.venueName,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormField(
                  controller: fullNameController,
                  headingText: "Name",
                  hintText: "Enter your full name",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormField(
                  controller: emailController,
                  headingText: "Email",
                  hintText: "Enter your email",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormField(
                  controller: phoneController,
                  headingText: "Phone Number/WhatsApp",
                  hintText: "Enter your whatsapp number",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormFieldWithSuffix(
                  isReadOnly: true,
                  controller: dateOfPreController,
                  headingText: "Date of reservation",
                  hintText: checkInDate,
                  onTap: ()async{
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
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextFormFieldLevel(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    String formatTimeOfDay(TimeOfDay tod) {
                      final hour = tod.hour.toString().padLeft(2, '0');
                      final minute = tod.minute.toString().padLeft(2, '0');
                      return '$hour:$minute';
                    }

                    if (pickedTime != null && context.mounted) {
                      setState(() {
                        selectedTime = formatTimeOfDay(pickedTime);
                      });
                    }
                  },
                  headingText: "Preferred Time Slot",
                  hintText: selectedTime, // toString() এর প্রয়োজন নেই
                  levelText: "From",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextEditingFormField(
                  controller: typeOfServicesController,
                  headingText: "Type of Service",
                  hintText: "SPA",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          // Validation Logic
                          if (fullNameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              typeOfServicesController.text.isEmpty||
                              phoneController.text.isEmpty ||
                              selectedTime.isEmpty ||
                              checkInDate.isEmpty ||
                              adultNumber == 0 && childrenNumber == 0) {
                            // GetX Snackbar show
                            Get.snackbar(
                              "Validation Error",
                              "Please fill all required fields before sending request",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withValues(alpha: 0.8),
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(10),
                              borderRadius: 8,
                            );
                            return; // Stop request
                          }


                          Get.snackbar(
                            "Success",
                            "Request sent successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green.withValues(alpha: 0.8),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            borderRadius: 8,
                          );

                          Map<String,dynamic> data={
                            "listingId": widget.listingId,
                            "bookingDate": checkInDateController.toString(),
                            "bookingTime": selectedTime,
                            "name": fullNameController.text,
                            "email": emailController.text,
                            "whatsapp": phoneController.text,
                            "venueName":widget.venueName,
                            "numberofguest_adult": adultNumber,
                            "numberofguest_child": childrenNumber,
                            "typeofservice":typeOfServicesController.text

                          };

                          final response=await FormRequestApiServices.formRequest(
                              data: data,
                              url: "bookings"
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
