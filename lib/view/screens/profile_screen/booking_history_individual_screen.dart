import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/view/widget/cancel_button.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/widget/request_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/event_controller/event_controller.dart';
import '../../../models/booking_history_model/booking_history_model.dart';
import '../../../models/event_upcoming_model/event_upcoming_model.dart';
import '../../widget/custom_event_widget.dart';
import 'event_history_individual_screen.dart';

class BookingHistoryIndividualScreen extends StatefulWidget {
  Event event;

  BookingHistoryIndividualScreen({super.key, required this.event});

  @override
  State<BookingHistoryIndividualScreen> createState() =>
      _BookingHistoryIndividualScreenState();
}

class _BookingHistoryIndividualScreenState
    extends State<BookingHistoryIndividualScreen> {
  final _eventController = Get.put(EventController());

  Future<void> _onRefresh() async {
    await _eventController.fetchUpcomingEvents();
    await _eventController.fetchPastEvents();
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(widget.event.date.toString());

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  CustomAppBar(title: 'Event history'),
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.event.eventImg),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          DateFormat('MMMM dd, yyyy').format(parsedDateTime),
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          widget.event.time,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Status:',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.event.status,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF00A600),
                                  fontSize: 14.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.title,
                            style: AppTextStyle.bold20,
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20.sp,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                widget.event.location,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AssetPath.lsiconUserCrowd,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Max: ${widget.event.maxPerson}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text('About This Event', style: AppTextStyle.bold20),
                  Text(
                    widget.event.description,
                    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  BookingCancleButton(onTap: () {}),
                  SizedBox(height: 8.h),
                  Obx(() {
                    if (_eventController.upcomingEvents.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("There are no upcoming event"),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _eventController.upcomingEvents.length,
                        itemBuilder: (context, index) {
                          final UpcomingEvent upcomingEvent =
                              _eventController.upcomingEvents[index];
                          return InkWell(
                            onTap: () {
                              Get.to(
                                EventHistoryIndividualPage(
                                  event: upcomingEvent,
                                  eventList: _eventController.upcomingEvents,
                                ),
                              );
                            },
                            child: CustomEventWidget(event: upcomingEvent),
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
      ),
    );
  }
}

class BookingCancleButton extends StatelessWidget {
  final Function() onTap;

  const BookingCancleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFFC7AE6A) /* Laser-300 */,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              'Cancel this event',
              style: TextStyle(
                color: const Color(0xFF1A1A1A) /* Woodsmoke-950 */,
                fontSize: 16,
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(),
              child: Icon(Icons.arrow_forward, color: Colors.black87, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
