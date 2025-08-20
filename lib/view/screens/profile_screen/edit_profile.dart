import 'package:abyansf_asfmanagment_app/view/widget/custom_app_bar.dart';
import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profile_controller/profile_controller.dart';


class EditProfile extends StatelessWidget {
   EditProfile({super.key});

  //bool isVisible = false;
  final _profileController=Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                      child: Icon(Icons.check, color: AppColors.green)),
                ),
                Text(
                  'Name',
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
                  'Phone number',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _profileController.phoneController,
                    decoration: InputDecoration(
                      //hintText: _profileController.user.value?.email
                    ),
                  ),
                ),
                // Text(
                //   'Password',
                //   textAlign: TextAlign.center,
                //   style: AppTextStyle.regular16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: TextFormField(
                //     obscureText: isVisible == false,
                //     decoration: InputDecoration(
                //       //hintText: 'mirable@1234',
                //       suffixIcon: IconButton(
                //         onPressed: () {
                //           setState(() {
                //             isVisible = !isVisible;
                //           });
                //         },
                //         icon: Icon(
                //           isVisible ? Icons.visibility : Icons.visibility_off,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Text(
                //   'Retype password',
                //   textAlign: TextAlign.center,
                //   style: AppTextStyle.regular16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: TextFormField(
                //     obscureText: isVisible == false,
                //     decoration: InputDecoration(
                //       //hintText: 'Retype password',
                //       suffixIcon: IconButton(
                //         onPressed: () {
                //           setState(() {
                //             isVisible = !isVisible;
                //           });
                //         },
                //         icon: Icon(
                //           isVisible ? Icons.visibility : Icons.visibility_off,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
