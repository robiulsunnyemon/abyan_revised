
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: SafeArea(
      //     child: CustomScrollView(
      //       slivers: [
      //         SliverToBoxAdapter(
      //           child: CustomAppBar(title: "Event Details"),
      //         ),
      //         Obx((){
      //           return SliverList.builder(
      //             itemCount: _notificationController.notifications.length,
      //             itemBuilder: (context, index) {
      //               return Padding(
      //                 padding: const EdgeInsets.all(7),
      //                 child: NotificationCardWidget(
      //                   title: _notificationController.notifications[index].title,
      //                   description: _notificationController.notifications[index].message,
      //                   time: _notificationController.notifications[index].createdAt.toString(),
      //                 ),
      //               );
      //             },
      //           );
      //         })
      //       ],
      //     )
      // ),
      body:  SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
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
