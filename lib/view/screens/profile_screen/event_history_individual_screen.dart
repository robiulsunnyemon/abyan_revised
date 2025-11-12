import 'package:abyansf_asfmanagment_app/models/event_upcoming_model/event_upcoming_model.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/event_controller/event_controller.dart';
import '../../widget/custom_event_card_two.dart';

class EventHistoryIndividualPage extends StatefulWidget {
  UpcomingEvent event;
  final List<UpcomingEvent> eventList;

  EventHistoryIndividualPage({
    super.key,
    required this.event,
    required this.eventList,
  });

  @override
  State<EventHistoryIndividualPage> createState() =>
      _EventHistoryIndividualPageState();
}

class _EventHistoryIndividualPageState
    extends State<EventHistoryIndividualPage> {
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
                  CustomAppBar(title: 'Event Details'),
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
                    children: [
                      Text(
                        DateFormat('MMMM dd, yyyy').format(parsedDateTime),
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.event.time,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Status:',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        widget.event.status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF00A600),
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
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

                  if (widget.event.status == "Active")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text("Skip", style: AppTextStyle.bold24),
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                _eventController.bookEvent(
                                  eventId: widget.event.id,
                                );
                              },
                              style: ElevatedButton.styleFrom(),
                              child: Text(
                                'Attend',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: 8.h),
                  if (widget.eventList.isNotEmpty)
                    Text('Upcoming Event', style: AppTextStyle.bold24),
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.eventList.length,
                      itemBuilder: (context, index) {
                        UpcomingEvent events = widget.eventList[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              widget.event = events;
                            });
                          },
                          child: CustomEventCardTwo(
                            status: true,
                            event: events,
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
      ),
    );
  }
}
