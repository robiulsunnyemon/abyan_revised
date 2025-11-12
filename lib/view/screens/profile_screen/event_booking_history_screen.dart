import 'package:abyansf_asfmanagment_app/models/booking_history_model/booking_history_model.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/booking_history_controller/booking_history_controller.dart';
import '../../widget/custom_bookin_event_widget.dart';
import 'booking_history_individual_screen.dart';

class EventBookingHistoryScreen extends StatelessWidget {
  EventBookingHistoryScreen({super.key});

  final EventBookingController _bookingController = Get.put(
    EventBookingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w), // responsive padding
            child: Column(
              children: [
                CustomAppBar(title: 'Booking History'),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            _bookingController.fetchUserAllBookings();
                            _bookingController.onClick(0);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.w),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            backgroundColor:
                                _bookingController.isSelect.value == 0
                                ? AppColors.primaryColor
                                : AppColors.white,
                          ),
                          child: Text(
                            'All',
                            style: AppTextStyle.regular16.copyWith(
                              fontSize: 16.sp, // responsive font
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            _bookingController.fetchUserAllPastBookings();
                            _bookingController.onClick(1);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.w),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            backgroundColor:
                                _bookingController.isSelect.value == 1
                                ? AppColors.primaryColor
                                : AppColors.white,
                          ),
                          child: Text(
                            'Past',
                            style: AppTextStyle.regular16.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            _bookingController.fetchUserAllActiveBookings();
                            _bookingController.onClick(2);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.w),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            backgroundColor:
                                _bookingController.isSelect.value == 2
                                ? AppColors.primaryColor
                                : AppColors.white,
                          ),
                          child: Text(
                            'Active',
                            style: AppTextStyle.regular16.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.blackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            _bookingController.fetchUserAllCancelBookings();
                            _bookingController.onClick(3);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.w),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            backgroundColor:
                                _bookingController.isSelect.value == 3
                                ? AppColors.primaryColor
                                : AppColors.white,
                          ),
                          child: Text(
                            'Cancel',
                            style: AppTextStyle.regular16.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.blackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  if (_bookingController.bookingsAll.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Center(
                        child: Text(
                          'You have no booking history',
                          style: TextStyle(fontSize: 14.sp), // responsive font
                        ),
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
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              BookingHistoryIndividualScreen(
                                event: bookingEvent.event,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: CustomBookingEventWidget(
                              bookingEvent: bookingEvent,
                            ),
                          ),
                        );
                      },
                    );
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
