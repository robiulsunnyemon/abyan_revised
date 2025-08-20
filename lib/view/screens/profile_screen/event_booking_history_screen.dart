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

  final EventBookingController _bookingController = Get.put(EventBookingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomAppBar(title: 'Booking History'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _bookingController.fetchUserAllBookings();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('All', style: AppTextStyle.regular16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _bookingController.fetchUserAllPastBookings();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('Past', style: AppTextStyle.regular16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _bookingController.fetchUserAllActiveBookings();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text('Active', style: AppTextStyle.regular16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _bookingController.fetchUserAllCancelBookings();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
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
              Obx(
                (){
                  if(_bookingController.bookingsAll.isEmpty){
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('You have no booking history'),
                    ));
                  }else{
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _bookingController.bookingsAll.length,
                      itemBuilder: (context, index) {
                        final Booking bookingEvent =
                        _bookingController.bookingsAll[index];
                        return CustomBookingEventWidget(bookingEvent: bookingEvent);
                      },
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
