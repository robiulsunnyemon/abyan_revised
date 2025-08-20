import 'package:abyansf_asfmanagment_app/models/event_upcoming_model/event_upcoming_model.dart';
import 'package:abyansf_asfmanagment_app/utils/assets_path.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/event_controller/event_controller.dart';
import '../screens/profile_screen/event_history_individual_screen.dart';

class CustomEventWidget extends StatelessWidget {
  final bool status;
  final Event? event;
   CustomEventWidget({super.key, this.status = false,  this.event});
  final _eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {

    DateTime parsedDateTime = DateTime.parse(event?.createdAt.toString() ?? DateTime.now().toString());

    return Card(
      color: AppColors.greyColor,
      child: GestureDetector(
        onTap: (){
          Get.to(EventHistoryIndividualPage(event: event!,eventList:_eventController.upcomingEvents,));
        },
        child: Container(
          width: double.infinity,
          height: 112.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(event?.eventImg ?? AppConstants.defaultImageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            event?.title ?? "Breakfast",
                            style: TextStyle(
                              fontFamily: "PlayfairDisplay",
                              fontSize: AppStyles.fontL,
                              fontWeight: AppStyles.weightBold,
                              color: AppColors.lightWhite6,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: AppColors.lightWhite6,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event?.location??'Dubai',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: AppStyles.fontS,
                                fontWeight: AppStyles.weightRegular,
                                color: AppColors.lightWhite6,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                     SizedBox(height: 12.h),
                    Row(
                      children: [
                        Text(
                          'Attendance?',
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: AppStyles.fontS,
                            fontWeight: AppStyles.weightRegular,
                            color: AppColors.lightWhite6,
                          ),
                        ),
                         SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: AppColors.primaryColor,
                              fontSize: AppStyles.fontS,
                              fontWeight: AppStyles.weightRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: status
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: AppStyles.weightRegular,
                        fontSize: AppStyles.fontM,
                        color: AppColors.lightLaserColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.lightLaserColor,
                        decorationThickness: 1.0,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontXS,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.lightWhite6,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontXS,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.lightWhite6,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
