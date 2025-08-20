import 'package:abyansf_asfmanagment_app/models/event_upcoming_model/event_upcoming_model.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../controller/event_controller/event_controller.dart';

class EventHistoryIndividualPage extends StatelessWidget {
  final Event event;
  final List<Event> eventList;
  EventHistoryIndividualPage({
    super.key,
    required this.event,
    required this.eventList,
  });
  final _eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {

    DateTime parsedDateTime = DateTime.parse(event.createdAt.toString());

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomAppBar(title: 'Event Details'),
                Container(
                  width: double.infinity,
                  height: 228.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(event.eventImg),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy').format(parsedDateTime),
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      event.time,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Status:',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      event.status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF00A600),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            event.title,
                            style: AppTextStyle.bold20,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: const BoxDecoration(),
                              child: Icon(
                                Icons.location_on,
                                size: 20,
                                color: AppColors.lightLaserColor,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              event.location,
                              style: TextStyle(
                                color: AppColors.lightLaserColor,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AssetPath.lsiconUserCrowd),
                        Text(
                          'Max: ${event.maxPerson}',
                          style: TextStyle(
                            color: const Color(0xFF2E2E2E),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text('About This Event', style: AppTextStyle.bold20),
                Text(event.description),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.lightLaserColor,
                          fontSize: 25.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () async {
                          _eventController.bookEvent(eventId: event.id);
                        },
                        style: ElevatedButton.styleFrom(),
                        child: Text('Attendance'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Upcoming Event', style: AppTextStyle.bold24),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(
                            EventHistoryIndividualPage(
                              event: eventList[index],
                              eventList: eventList,
                            ),
                          );
                        },
                        child: CustomEventWidget(
                          status: true,
                          event: eventList[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
