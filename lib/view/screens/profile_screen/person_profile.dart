import 'package:abyansf_asfmanagment_app/controller/profile_controller/profile_controller.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/edit_profile.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/view_models/controller/image_picker_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PersonProfile extends StatelessWidget {
   PersonProfile({super.key});
  final ImagePickerController _imagePickerController = Get.find();
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16),
            child: Column(
              children: [
                CustomAppBar(title:' Edit Profile',action:
                IconButton(onPressed: (){
                  Get.to(() => EditProfile());
                }, icon: Icon(Icons.edit)),),
                Row(
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
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Info',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular20,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Full Name',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: TextFormField(
                            controller: _profileController.nameController,
                            decoration: InputDecoration(
                              //hintText: _profileController.user.value?.name
                            ),
                          ),
                        ),
                        Text(
                          'Email',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: TextFormField(
                            controller: _profileController.emailController,
                            decoration: InputDecoration(
                              //hintText: _profileController.user.value?.name
                            ),
                          ),
                        ),
                        Text(
                          'Contact number',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: TextFormField(
                            controller: _profileController.phoneController,
                            decoration: InputDecoration(
                              hintText: _profileController.user.value?.email,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
