
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:abyansf_asfmanagment_app/models/event_upcoming_model/event_upcoming_model.dart';
import '../../utils/style/appColor.dart';
import '../../utils/style/appStyle.dart';
import '../screens/constant/constans.dart';


class CustomEventCardTwo extends StatelessWidget {
  final bool status;
  final UpcomingEvent event;
  const CustomEventCardTwo({super.key, this.status = false, required this.event});

  @override
  Widget build(BuildContext context) {

    DateTime parsedDateTime = DateTime.parse(event.createdAt.toString() ?? DateTime.now().toString());

    return Card(
        color: AppColors.white,
        child: Container(
          width: double.infinity,
          height: 95.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        event.eventImg ?? AppConstants.defaultImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                ,
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
                            event.title ?? "Breakfast",
                            style: TextStyle(
                              fontFamily: "copperplategothic",
                              fontWeight: AppStyles.weightBold,
                              color: AppColors.blackColor,
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
                              color: AppColors.blackColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.location??'Dubai',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: AppStyles.fontS,
                                fontWeight: AppStyles.weightRegular,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if(!status)
                      Row(
                        children: [
                          Text(
                            'Attend?',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: AppStyles.fontS,
                              fontWeight: AppStyles.weightRegular,
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: AppColors.goldenTextColor,
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
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM').format(parsedDateTime),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: AppStyles.fontXS,
                        fontWeight: AppStyles.weightRegular,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )

    );
  }
}