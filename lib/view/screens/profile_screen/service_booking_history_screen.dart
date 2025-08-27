import 'package:abyansf_asfmanagment_app/controller/service_booking_controller/service_booking_controller.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_service_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ServiceBookingHistoryScreen extends StatelessWidget {
  ServiceBookingHistoryScreen({super.key});

  final _bookingController = Get.put(ServicesBookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomAppBar(title: 'Booking History'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6).r,
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.changeStatusType("All");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(6).r,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50).r,
                          ),
                        ),
                        child: Text('All', style: AppTextStyle.regular16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0).r,
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.changeStatusType("Pending");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(6).r,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text('Pending', style: AppTextStyle.regular16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6).r,
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.changeStatusType("Active");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(6).r,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text('Confirm', style: AppTextStyle.regular16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0).r,
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.changeStatusType("Cancel");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(6).r,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text('Cancel', style: AppTextStyle.regular16),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (_bookingController.statusType.value == "All") {
                    if (_bookingController.allBookings.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('You have no booking history'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _bookingController.allBookings.length,
                        itemBuilder: (context, index) {
                          if (_bookingController.allBookings[index].type ==
                              'subcategory') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .allBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .allBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status:
                                  _bookingController.allBookings[index].status,
                              location:
                                  _bookingController
                                      .allBookings[index]
                                      .bookingInfo
                                      ?.location
                                      .from ??
                                  "Null",
                              title:
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          } else if (_bookingController
                                  .allBookings[index]
                                  .type ==
                              'listing') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .allBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .allBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status:
                                  _bookingController.allBookings[index].status,
                              location:
                                  _bookingController
                                      .allBookings[index]
                                      .listing
                                      ?.location ??
                                  "",
                              title:
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                        },
                      );
                    }
                  }
                  if (_bookingController.statusType.value == "Pending") {
                    if (_bookingController.pendingBookings.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('You have no booking history'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _bookingController.pendingBookings.length,
                        itemBuilder: (context, index) {
                          if (_bookingController.pendingBookings[index].type ==
                              'subcategory') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .pendingBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .pendingBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .pendingBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .pendingBookings[index]
                                      .bookingInfo
                                      ?.location
                                      .from ??
                                  "Null",
                              title:
                                  _bookingController
                                      .pendingBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .pendingBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                          if (_bookingController.pendingBookings[index].type ==
                              'listing') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .pendingBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .pendingBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .pendingBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .pendingBookings[index]
                                      .listing
                                      ?.location ??
                                  "",
                              title:
                                  _bookingController
                                      .pendingBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .pendingBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                        },
                      );
                    }
                  }

                  if (_bookingController.statusType.value == "Active") {
                    if (_bookingController.confirmedBookings.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('You have no booking history'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _bookingController.confirmedBookings.length,
                        itemBuilder: (context, index) {
                          if (_bookingController
                                  .confirmedBookings[index]
                                  .type ==
                              'subcategory') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .confirmedBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .confirmedBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .bookingInfo
                                      ?.location
                                      .from ??
                                  "Null",
                              title:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .confirmedBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                          if (_bookingController
                                  .confirmedBookings[index]
                                  .type ==
                              'listing') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .confirmedBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .confirmedBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .listing
                                      ?.location ??
                                  "",
                              title:
                                  _bookingController
                                      .confirmedBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .confirmedBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                        },
                      );
                    }
                  }

                  if (_bookingController.statusType.value == "Cancel") {
                    if (_bookingController.cancelledBookings.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('You have no booking history'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _bookingController.cancelledBookings.length,
                        itemBuilder: (context, index) {
                          if (_bookingController
                                  .cancelledBookings[index]
                                  .type ==
                              'subcategory') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .cancelledBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .cancelledBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .bookingInfo
                                      ?.location
                                      .from ??
                                  "Null",
                              title:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .cancelledBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          } else if (_bookingController
                                  .cancelledBookings[index]
                                  .type ==
                              'listing') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .cancelledBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status: _bookingController
                                  .cancelledBookings[index]
                                  .status,
                              location:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .listing
                                      ?.location ??
                                  "",
                              title:
                                  _bookingController
                                      .cancelledBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .cancelledBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                        },
                      );
                    }
                  } else {
                    if (_bookingController.allBookings.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('You have no booking history'),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _bookingController.allBookings.length,
                        itemBuilder: (context, index) {
                          if (_bookingController.allBookings[index].type ==
                              'subcategory') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .allBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .allBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status:
                                  _bookingController.allBookings[index].status,
                              location:
                                  _bookingController
                                      .allBookings[index]
                                      .bookingInfo
                                      ?.location
                                      .from ??
                                  "Null",
                              title:
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                          if (_bookingController.allBookings[index].type ==
                              'listing') {
                            return CustomServiceBookingWidget(
                              createdDate: _bookingController
                                  .allBookings[index]
                                  .createdAt
                                  .toString(),
                              imageUrl:
                                  _bookingController
                                      .allBookings[index]
                                      .subCategory
                                      ?.img ??
                                  AppConstants.defaultImageUrl,
                              status:
                                  _bookingController.allBookings[index].status,
                              location:
                                  _bookingController
                                      .allBookings[index]
                                      .listing
                                      ?.location ??
                                  "",
                              title:
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  _bookingController
                                      .allBookings[index]
                                      .miniSubCategory
                                      ?.name ??
                                  "",
                            );
                          }
                        },
                      );
                    }
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
