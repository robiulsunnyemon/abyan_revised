import 'package:abyansf_asfmanagment_app/models/booking_history_model/booking_history_model.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/booking_history_controller/booking_history_controller.dart';
import '../../widget/custom_bookin_event_widget.dart';

class EventBookingHistoryScreen extends StatelessWidget {
  EventBookingHistoryScreen({super.key});

  final EventBookingController _bookingController = Get.put(
    EventBookingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomAppBar(title: 'Booking History'),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.fetchUserAllBookings();
                          _bookingController.onClick(0);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: _bookingController.isSelect.value == 0
                              ? AppColors.primaryColor
                              : AppColors.lightGrey,
                        ),
                        child: Text(
                          'All',
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.fetchUserAllPastBookings();
                          _bookingController.onClick(1);

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: _bookingController.isSelect.value == 1
                              ? AppColors.primaryColor
                              : AppColors.lightGrey,
                        ),
                        child: Text(
                          'Past',
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.fetchUserAllActiveBookings();
                          _bookingController.onClick(2);

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: _bookingController.isSelect.value ==2
                              ? AppColors.primaryColor
                              : AppColors.lightGrey,
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _bookingController.fetchUserAllCancelBookings();
                          _bookingController.onClick(3);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: _bookingController.isSelect.value == 3
                              ? AppColors.primaryColor
                              : AppColors.lightGrey,
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTextStyle.regular16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (_bookingController.bookingsAll.isEmpty) {
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
                    itemCount: _bookingController.bookingsAll.length,
                    itemBuilder: (context, index) {
                      final Booking bookingEvent =
                          _bookingController.bookingsAll[index];
                      return CustomBookingEventWidget(
                        bookingEvent: bookingEvent,
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
