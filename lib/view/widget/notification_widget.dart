import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  const NotificationCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.time,
  });

  String _formatTimeAgo(String timeStamp) {
    try {
      DateTime pastTime = DateTime.parse(timeStamp).toUtc();
      DateTime now = DateTime.now().toUtc();
      Duration difference = now.difference(pastTime);

      if (difference.inMinutes < 60) {
        return "${difference.inMinutes}min ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else {
        return "${difference.inDays}d ago";
      }
    } catch (e) {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = _formatTimeAgo(time);

    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x14000000),
            blurRadius: 30,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.h,
            decoration: ShapeDecoration(
              color: const Color(0xFFF8F6EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
          SizedBox(width: 15.w),
          SizedBox(
            width: 250.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.h,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formattedTime,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF6D6D6D),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFBD9B52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(68),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}