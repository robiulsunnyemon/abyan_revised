

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appStyle.dart';
import '../../controller/profile_controller/profile_controller.dart';
import '../screens/constant/constans.dart';
import '../screens/single_services_pages/notification_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showTitle;
  final ProfileController _profileController = Get.put(ProfileController());

   HomeAppBar({super.key, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.white,
      child: _buildAppBarContent(),
    );
  }

  Widget _buildAppBarContent() {
    return showTitle
        ? _buildTitleVersion()
        : _buildDefaultVersion();
  }

  Widget _buildTitleVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGreetingWithSubtitle(),
        _buildNotificationIcon(),
      ],
    );
  }

  Widget _buildDefaultVersion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAvatarWithGreeting(),
        Row(
          children: [
            _buildLocationChip(),
            SizedBox(width: 10.w),
            _buildNotificationIcon(),
          ],
        ),
      ],
    );
  }

  Widget _buildGreetingWithSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Obx(()=>Text(
            _profileController.user.value?.name?? "known",
            style: _nameTextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),)
        ),
        const SizedBox(height: 2),
        Text(
          "Find the amazing event near you",
          style: _subtitleTextStyle(),
        ),
      ],
    );
  }

  Widget _buildAvatarWithGreeting() {
    return Row(
      children: [
         Obx(()=>CircleAvatar(
             radius: 22,
             backgroundImage: NetworkImage( _profileController.user.value?.profilePic ?? AppConstants.defaultImageUrl )
         ),),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Obx(()=>Text(
            _profileController.user.value?.name??"known",
            style: _nameTextStyle(fontSize: AppStyles.fontL),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),),
        ),
      ],
    );
  }

  Widget _buildLocationChip() {
    return Container(
      height: 39,
      width: 91,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 16,
            color: AppColors.lightWhite6,
          ),
          const SizedBox(width: 4),
          Text(
            'Dubai',
            style: _locationTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return GestureDetector(
      onTap: () => Get.to(() =>  NotificationScreen()),
      child: const Icon(Icons.notification_add),
    );
  }

  TextStyle _nameTextStyle({double fontSize = AppStyles.fontXL}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: AppStyles.weightMedium,
      fontFamily: "Inter",
      color: AppColors.blackColor,
    );
  }

  TextStyle _subtitleTextStyle() {
    return TextStyle(
      fontSize: AppStyles.fontM,
      fontWeight: AppStyles.weightRegular,
      fontFamily: "Inter",
      color: AppColors.blackColor,
    );
  }

  TextStyle _locationTextStyle() {
    return TextStyle(
      fontSize: AppStyles.fontS,
      fontWeight: AppStyles.weightRegular,
      fontFamily: "Inter",
      color: AppColors.lightWhite6,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}