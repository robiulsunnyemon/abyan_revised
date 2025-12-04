/*

import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/notification_controller/notification_controller.dart';
import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';
import '../../widget/notification_widget.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});

   final NotificationController _notificationController = Get.put(NotificationController());

   Future<void> _onRefresh() async {

     await _notificationController.fetchNotifications();

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomAppBar(title: 'Notification'),
                  SizedBox(
                    child: Obx(()=>ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:_notificationController.notifications.length,
                      itemBuilder: (context, index) {

                        String formatTimeAgo(String timeStamp) {
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

                        final formattedTime = formatTimeAgo(_notificationController.notifications[index].createdAt.toString());
                        return Card(
                          elevation: 20,
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                _notificationController.notifications[index].title ?? '',
                                style: AppTextStyle.bold16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                _notificationController.notifications[index].message ?? '',
                                style: AppTextStyle.regular12.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedTime ?? '',
                                    style: AppTextStyle.interRegular10,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    margin: const EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryDeepColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: AppColors.primaryDeepColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),)
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
*/
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/notification_controller/notification_controller.dart';
import '../../../utils/style/appColor.dart';
import '../../../utils/style/app_text_styles.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController _notificationController =
  Get.put(NotificationController());

  Future<void> _onRefresh() async {
    await _notificationController.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomAppBar(title: 'Notification'),
                  const SizedBox(height: 10),

                  /// MAIN NOTIFICATION LIST
                  Obx(
                        () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _notificationController.notifications.length,
                      itemBuilder: (context, index) {
                        final notification =
                        _notificationController.notifications[index];

                        /// Time Format Function
                        String formatTimeAgo(String timeStamp) {
                          try {
                            DateTime pastTime =
                            DateTime.parse(timeStamp).toUtc();
                            DateTime now = DateTime.now().toUtc();
                            Duration difference = now.difference(pastTime);

                            if (difference.inMinutes < 60) {
                              return "${difference.inMinutes} min ago";
                            } else if (difference.inHours < 24) {
                              return "${difference.inHours} h ago";
                            } else {
                              return "${difference.inDays} d ago";
                            }
                          } catch (e) {
                            return "Just now";
                          }
                        }

                        final formattedTime =
                        formatTimeAgo(notification.createdAt.toString());

                        final bool isRead = notification.isRead == true;

                        return GestureDetector(
                          onTap: () {
                            _notificationController.markAsRead(index);
                          },
                          child: Card(
                            elevation: 8,
                            color: isRead
                                ? Colors.black // READ → Black background
                                : Colors.white, // UNREAD → White background
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(
                                  notification.title,
                                  style: AppTextStyle.bold16.copyWith(
                                    color: isRead
                                        ? AppColors.goldenTextColor
                                        : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  notification.message,
                                  style: AppTextStyle.regular12.copyWith(
                                    color: isRead
                                        ? Colors.white
                                        : AppColors.textColor,
                                  ),
                                ),

                                /// RIGHT SIDE TIME + DOT
                                trailing: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formattedTime,
                                      style:
                                      AppTextStyle.interRegular10.copyWith(
                                        color: isRead
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),

                                    /// Dot only when NOT read
                                    if (!isRead)
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryDeepColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),

                                /// ICON
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    color: AppColors.primaryDeepColor,
                                  ),
                                ),
                              ),
                            ),
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
