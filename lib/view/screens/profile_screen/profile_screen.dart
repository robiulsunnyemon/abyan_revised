import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/event_booking_history_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/help_support.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/person_profile.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/privacy_policy.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/admin_whatsapp_controller/admin_whatsapp_controller.dart';
import '../../../controller/profile_controller/profile_controller.dart';
import '../../../utils/assets_path.dart';
import '../../../utils/style/app_text_styles.dart';
import '../../../view_models/controller/image_picker_controller.dart';
import '../single_services_pages/profile_cutom_appbar.dart';
import 'invite_friend_show_log.dart';
import 'service_booking_history_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ImagePickerController _imagePickerController = Get.find();
  final ProfileController _profileController = Get.put(ProfileController());
  final _adminWhatsappController = Get.put(AdminWhatsAppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: AppTextStyle.bold24,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        /*actions: [
          IconButton(onPressed: (){
            Get.to(() => EditProfile());
          }, icon: Icon(Icons.edit))
        ],*/
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Obx(
                              () => CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _profileController.user.value?.profilePic ??
                                      AppConstants.defaultImageUrl,
                                ),
                                radius: 34,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () => _imagePickerController.pickImage(),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                _profileController.user.value?.name ?? "Known",
                                style: AppTextStyle.bold20,
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Package',
                                style: AppTextStyle.interBold10.copyWith(
                                  color: AppColors.blackColor,
                                ), // Your custom text style
                              ),
                              backgroundColor: const Color(0xFFC7AE6A),
                              // Background color
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              // Responsive padding using ScreenUtil
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  25.r,
                                ), // Responsive border radius using ScreenUtil
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRowItem(
                          icon: Icons.person,
                          text: 'Account',
                          isArrowTrue: true,
                          onTap: () {
                            Get.to(() => PersonProfile());
                          },
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(height: 12.h),
                        buildRowItem(
                          icon: Icons.calendar_month,
                          text: 'Event History',
                          isArrowTrue: true,
                          onTap: () {
                            Get.to(EventBookingHistoryScreen());
                          },
                        ),
                        SizedBox(height: 12.h),
                        buildRowItem(
                          icon: Icons.people,
                          onTap: () {
                            InviteFriendShowLog.show(context);
                          },
                          text: 'Invite a friend',
                          isArrowTrue: true,
                        ),
                        SizedBox(height: 12.h),
                        buildRowItem(
                          icon: Icons.settings,
                          onTap: () {
                            Get.to(() => PrivacyPolicy());
                          },
                          text: 'Privacy & policy',
                          isArrowTrue: true,
                        ),
                        SizedBox(height: 12.h),
                        buildRowItem(
                          icon: Icons.headset_mic_outlined,
                          onTap: () {
                            Get.to(() => HelpSupport());
                          },
                          text: 'Help & Support',
                          isArrowTrue: true,
                        ),
                        SizedBox(height: 12.h),
                        buildRowItem(
                          icon: Icons.logout,
                          onTap: () async {
                            await AuthPrefService.clearToken();
                            if (AuthPrefService.token.value.trim().isEmpty) {
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                            } else {
                              print("else");
                            }
                          },
                          text: 'Log Out',
                          isArrowTrue: true,
                          isRedColor: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowItem({
    required IconData icon,
    required String text,
    bool isArrowTrue = false,
    required VoidCallback onTap,
    bool isRedColor = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20.sp,
                      color: isRedColor
                          ? Colors.red
                          : AppColors.goldenTextColor,
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: isRedColor ? Colors.red : AppColors.white,
                          fontSize: 16.sp,
                          fontFamily: 'copperplategothic',
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                if (isArrowTrue)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: AppColors.white,
                  ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  /*Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backGroundColor,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 150.h,
            width: 200.w,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.to(() => EventBookingHistoryScreen());
                        },
                        child: Text("Event Booking History"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.to(() => ServiceBookingHistoryScreen());
                        },
                        child: Text("Service Booking History"),
                      ),
                    ],
                  ),
                ),

                // Top-right X button
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/


}
