
import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api_services/profile_api_services/profile_api_services.dart';
import '../../models/user_profile_models/user_model.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Initialize controllers immediately with empty values
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void onInit() {
    // Initialize with empty values first
    _resetControllers();
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading(true);
      errorMessage('');
      final response = await ProfileApiServices.getUserProfile();
      if (response.statusCode == 200) {
        final userResponse = UserResponse.fromJson(json.decode(response.body));
        final userResponseData = userResponse.data;
        user(userResponseData);

        // Update controllers with new values
        phoneController.text = userResponseData.whatsapp ?? '';
        emailController.text = userResponseData.email ?? '';
        nameController.text = userResponseData.name ?? '';
        imageController.text = userResponseData.profilePic ?? '';
        update();
        Get.to(CustomBottomBar());
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to fetch profile: ${e.toString()}');
      // Reset to empty values on error
      _resetControllers();
    } finally {
      isLoading(false);
    }
  }

  // Helper method to reset controllers
  void _resetControllers() {
    phoneController.text = '';
    emailController.text = '';
    nameController.text = '';
    imageController.text = '';
  }

  // Future<void> updateUserProfile() async {
  //   try {
  //     isLoading(true);
  //     errorMessage('');
  //     final response= await ProfileApiServices.updateUserProfile(
  //         name: nameController.text,
  //         phone: phoneController.text
  //     );
  //
  //     if(response.statusCode==200){
  //       await fetchUserProfile();
  //       Get.snackbar('Success', 'Profile updated successfully');
  //     }else{
  //      Get.snackbar('Error', 'Failed to update profile');
  //     }
  //
  //
  //   } catch (e) {
  //     errorMessage(e.toString());
  //     Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> updateUserProfile() async {
    try {
      isLoading(true);
      errorMessage('');

      // Create a map to hold only the changed fields
      Map<String, dynamic> updatedFields = {};

      // Check which fields have changed compared to the original user data
      if (user.value != null) {
        if (nameController.text != user.value!.name) {
          updatedFields['name'] = nameController.text;
        }
        if (phoneController.text != user.value!.whatsapp) {
          updatedFields['whatsapp'] = phoneController.text;
        }
        // Add other fields similarly if needed
      }

      // Only proceed if there are actually any changes
      if (updatedFields.isNotEmpty) {
        final response = await ProfileApiServices.updateUserProfile(data: updatedFields);

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          if (responseData['success'] == true) {
            await fetchUserProfile();
            Get.snackbar('Success', responseData['message'] ?? 'Profile updated successfully');
          } else {
            Get.snackbar('Error', responseData['message'] ?? 'Failed to update profile');
          }
        } else {
          Get.snackbar('Error', 'Failed to update profile');
        }
      } else {
        Get.snackbar('Info', 'No changes detected to update');
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }



  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    imageController.dispose();
    super.onClose();
  }
}