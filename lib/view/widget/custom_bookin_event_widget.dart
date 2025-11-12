import 'package:abyansf_asfmanagment_app/models/booking_history_model/booking_history_model.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class CustomBookingEventWidget extends StatelessWidget {
  final Booking bookingEvent;
  const CustomBookingEventWidget({super.key, required this.bookingEvent});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(bookingEvent.createdAt.toString());
    return Card(
      color: AppColors.white,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)), // responsive radius
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 75.h,
                  width: 75.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: NetworkImage(bookingEvent.event.eventImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            'Status: ',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: AppStyles.fontXL.sp,
                              fontWeight: AppStyles.weightRegular,
                              color: AppColors.blackColor,
                              overflow: TextOverflow.ellipsis,
                            ),maxLines: 1,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            bookingEvent.status,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: AppStyles.fontL.sp,
                              fontWeight: AppStyles.weightRegular,
                              color: AppColors.blackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookingEvent.event.title,
                          style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            fontSize: AppStyles.fontL.sp,
                            fontWeight: AppStyles.weightBold,
                            color: AppColors.blackColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16.sp,
                              color: AppColors.blackColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              bookingEvent.event.location,
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: AppStyles.fontS.sp,
                                fontWeight: AppStyles.weightRegular,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('hh:mm a').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: AppStyles.weightRegular,
                        fontSize: AppStyles.fontM.sp,
                        color: AppColors.lightLaserColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.goldenTextColor,
                        decorationThickness: 1.0,
                        height: 1.4.h,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      DateFormat('EEEE').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontXS.sp,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.blackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('d MMMM').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontXS.sp,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.blackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

