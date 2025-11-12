import 'package:abyansf_asfmanagment_app/view/screens/constant/constans.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view_models/controller/image_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller/profile_controller.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isVisible = false;

  final _profileController = Get.put(ProfileController());
  final ImagePickerController _imagePickerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: 'Edit Profile',
                  action: GestureDetector(
                    onTap: () {
                      _profileController.updateUserProfile();
                    },
                    child: Icon(Icons.check, color: AppColors.green),
                  ),
                ),
                SizedBox(height: 20),
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
                    Obx(
                          () => Text(
                        _profileController.user.value?.name ?? "Known",
                        style: AppTextStyle.bold20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
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
                        const SizedBox(height: 10),
                        Text(
                          'Full Name',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: _profileController.emailController,
                            decoration: InputDecoration(
                              //hintText: _profileController.user.value?.name
                            ),
                          ),
                        ),
                        Text(
                          'Phone number',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                const SizedBox(height: 16),
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
                          'Password',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular20,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Create Password',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            obscureText: isVisible == false,
                            decoration: InputDecoration(
                              hintText: '*******',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Retype password',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            obscureText: isVisible == false,
                            decoration: InputDecoration(
                              hintText: '*******',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(onPressed: (){}, child: Text('Profile Update'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
