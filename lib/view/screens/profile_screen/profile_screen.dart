// import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/privacy_policy.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../controller/profile_controller/profile_controller.dart';
// import '../../../utils/assets_path.dart';
// import '../../widget/custom_app_bar.dart';
// import '../../../utils/style/appColor.dart';
// import '../../../utils/style/app_text_styles.dart';
// import '../../../view_models/controller/image_picker_controller.dart';
// import 'service_booking_history_screen.dart';
// import 'edit_profile.dart';
// import 'invite_friend_show_log.dart';
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
//
//   final ImagePickerController _imagePickerController = Get.find();
//   final _profileController = Get.put(ProfileController());
//   final List<Map<String, dynamic>> items = [
//     {
//       'leading': SvgPicture.asset(
//         AssetPath.solarCalendar,
//         height: 20,
//         width: 20,
//       ),
//       'title': Text('Booking History', style: AppTextStyle.regular16),
//       'trailing': Icon(Icons.arrow_forward_ios),
//       'route': BookingHistory(),
//     },
//     {
//       'leading': SvgPicture.asset(AssetPath.solarSettings),
//       'title': Text('Account settings', style: AppTextStyle.regular16),
//       'trailing': Icon(Icons.arrow_forward_ios),
//       'route': EditProfile(),
//     },
//     {
//       'leading': SvgPicture.asset(
//         AssetPath.solarCalendar,
//         height: 20,
//         width: 20,
//       ),
//       'title': Text('Invite your friend', style: AppTextStyle.regular16),
//       'trailing': Icon(Icons.arrow_forward_ios),
//       'onTap': (BuildContext context) {
//         InviteFriendShowLog.show(context);
//       },
//     },
//     {
//       'leading': SvgPicture.asset(AssetPath.privacyPolicy),
//       'title': Text('Privacy & policy', style: AppTextStyle.regular16),
//       'trailing': Icon(Icons.arrow_forward_ios),
//       'route': PrivacyPolicy(),
//     },
//     {
//       'leading': Icon(Icons.logout, color: AppColors.red),
//       'title': Text(
//         'Log Out',
//         style: TextStyle(
//           color: AppColors.red,
//           fontSize: 16,
//           fontFamily: 'Playfair Display',
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       'trailing': Icon(Icons.arrow_forward_ios),
//       'route': Scaffold(body: Container(color: Colors.yellow)),
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Obx(
//                 () => Column(
//                   children: [
//                     CustomAppBar(
//                       title: 'My Profile',
//                       // action: InkWell(onTap:  Get.to(),child: Image.asset(AssetPath.basilEditOutline,height: 24,width: 24,)),
//                       action: IconButton(
//                         onPressed: () {
//                           Get.to(EditProfile());
//                         },
//                         icon: Image.asset(AssetPath.basilEditOutline),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             CircleAvatar(
//                               backgroundImage: AssetImage(
//                                 AssetPath.profileImage,
//                               ),
//                               radius: 34,
//                               backgroundColor: Colors.white,
//                             ),
//                             Positioned(
//                               bottom: 5,
//                               right: 5,
//                               child: InkWell(
//                                 onTap: () => _imagePickerController.pickImage(),
//                                 child: Container(
//                                   width: 20,
//                                   height: 20,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.white,
//                                   ),
//                                   child: Icon(
//                                     Icons.camera_alt_outlined,
//                                     size: 13,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 20),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               _profileController.user.value?.name ?? "Demo",
//                               style: AppTextStyle.bold24,
//                             ),
//                             Text(
//                               _profileController.user.value!.id,
//                               style: AppTextStyle.regular12,
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: 5),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFC7AE6A),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Text(
//                             'Premium',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     _infoRow(
//                       Icons.phone,
//                       _profileController.user.value!.whatsapp,
//                     ),
//                     SizedBox(height: 12),
//                     _infoRow(Icons.email, _profileController.user.value!.email),
//                   ],
//                 ),
//               ),
//             ),
//
//             Divider(),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return ListTile(
//                     leading: item['leading'],
//                     title: item['title'],
//                     trailing: item['trailing'],
//                     onTap: () {
//                       if (item.containsKey('onTap')) {
//                         item['onTap'](context);
//                       } else {
//                         Get.to(item['route']);
//                       }
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget _infoRow(IconData icon, String text) {
//   return Row(
//     children: [
//       Icon(icon, size: 20, color: Colors.black54),
//       SizedBox(width: 12),
//       Text(
//         text,
//         style: TextStyle(
//           color: Color(0xFF454545),
//           fontSize: 16,
//           fontFamily: 'Inter',
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     ],
//   );
// }

import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/auth/loginScreen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/event_booking_history_screen.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/privacy_policy.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ProfileCustomAppbar(
                      title: 'My Profile',
                      action: IconButton(
                        onPressed: () {
                          Get.to(EditProfile());
                        },
                        icon: Image.asset(AssetPath.basilEditOutline),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                                  onTap: () =>
                                      _imagePickerController.pickImage(),
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
                                  _profileController.user.value?.name ??
                                      "Known",
                                  style: AppTextStyle.bold20,
                                ),
                              ),
                              Chip(
                                label: Text(
                                  'Private',
                                  style: AppTextStyle
                                      .interBold10, // Your custom text style
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
                            icon: Icons.phone,
                            text: _profileController.phoneController.text,
                            onTap: () {},
                          ),

                          SizedBox(height: 12.h),
                          buildRowItem(
                            icon: Icons.mail,
                            text: _profileController.emailController.text,
                            onTap: () {},
                          ),
                          SizedBox(height: 12.h),
                          buildRowItem(
                            icon: Icons.calendar_month,
                            text: 'Booking History',
                            isArrowTrue: true,
                            onTap: () {
                              showMyDialog(context);
                            },
                          ),
                          SizedBox(height: 12.h),
                          buildRowItem(
                            icon: Icons.people,
                            onTap: () {
                              InviteFriendShowLog.show(context);
                            },
                            text: 'Invite your friend',
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
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: isRedColor ? Colors.red : Colors.black54,
                ),
                SizedBox(width: 15.w),
                Text(
                  text,
                  style: TextStyle(
                    color: isRedColor ? Colors.red : const Color(0xFF454545),
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (isArrowTrue) Icon(Icons.arrow_forward_ios, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 200.h,
            width: 200.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
        );
      },
    );
  }
}
