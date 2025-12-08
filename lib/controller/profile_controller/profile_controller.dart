
import 'dart:convert';
import 'package:abyansf_asfmanagment_app/view/widget/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api_services/profile_api_services/profile_api_services.dart';
import '../../models/user_profile_models/user_model.dart';

class ProfileController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
       // Get.to(CustomBottomBar());
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

  Future<void> updateUserProfile() async {
    try {
      isLoading(true);
      errorMessage('');

      Map<String, dynamic> updatedFields = {};

      if (user.value != null) {
        if (nameController.text.trim().isNotEmpty &&
            nameController.text.trim() != (user.value!.name ?? '')) {
          updatedFields['name'] = nameController.text.trim();
        }
        if (phoneController.text.trim().isNotEmpty &&
            phoneController.text.trim() != (user.value!.whatsapp ?? '')) {
          updatedFields['whatsapp'] = phoneController.text.trim();
        }

        if (emailController.text.trim().isNotEmpty &&
            emailController.text.trim() != (user.value!.email ?? '')) {
          updatedFields['email'] = emailController.text.trim();
        }
      }

      // Password validation
      if (passwordController.text.isNotEmpty ||
          confirmPasswordController.text.isNotEmpty) {
        if (passwordController.text != confirmPasswordController.text) {
          Get.snackbar("Error", "Password & Confirm Password do not match");
          return;
        }
        if (passwordController.text.length < 6) {
          Get.snackbar("Error", "Password must be at least 6 characters");
          return;
        }
        updatedFields['password'] = passwordController.text;
      }

      if (updatedFields.isEmpty) {
        Get.snackbar('Info', 'No changes detected to update');
        return;
      }

      print("Update body sent to API: $updatedFields");

      final response = await ProfileApiServices.updateUserProfile(data: updatedFields);
 print("response ////////////${response.body},${response.statusCode}");

      if (response.statusCode == 200) {
        // JSON parsing
        try {
          final res = jsonDecode(response.body);
          if (res['success'] == true) {
            await fetchUserProfile();
            passwordController.clear();
            confirmPasswordController.clear();
            Get.snackbar('Success', res['message'] ?? 'Profile updated');
          } else {
            Get.snackbar('Error', res['message'] ?? 'Update failed');
          }
        } catch (e) {
          print("Non-JSON response: ${response.body}");
          Get.snackbar("Error", "API rejected request: ${response.body}");
        }
      } else {
        Get.snackbar('Error', 'Failed to update profile. Status code: ${response.statusCode}');
        print("Response body: ${response.body}");
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Update failed: $e');
      print(e);
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