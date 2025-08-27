import 'dart:convert';

import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:abyansf_asfmanagment_app/view/auth/verificationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../api_services/registration_api-services/registration_api_services.dart';
import '../../recovery_verification_screen.dart';

class SignUpController extends GetxController {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController whatsappTEController = TextEditingController();



  Future<void> signup() async {
    try {


      if(nameTEController.text.isEmpty || emailTEController.text.isEmpty || whatsappTEController.text.isEmpty){
        Get.snackbar('Error', 'Please fill in all the fields.');
        return;
      }




      Map<String, dynamic> body = {
        "name": nameTEController.text.trim(),
        "email": emailTEController.text.trim(),
        "whatsapp": whatsappTEController.text.trim(),
      };

      final response = await RegistrationApiServices.signupRequest(body: body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        print("got to function");
        final decodedResponse = jsonDecode(response.body);
        print(decodedResponse['userId']);

        await AuthPrefService.saveUid(decodedResponse['userId']);
        await AuthPrefService.saveEmail(body['email']);
        await AuthPrefService.saveUserName(body["name"]);
        await AuthPrefService.loadUid();
        await AuthPrefService.loadEmail();
        await AuthPrefService.loadUserName();

        print("user email from auth pref service after load${AuthPrefService.userEmail.value}");
        print("user userId from auth pref service after load${AuthPrefService.uid.value}");
        print("user userName from auth pref service after load${AuthPrefService.userName.value}");


        Get.to(() => RecoveryVerificationScreen());
      }else{
        Get.snackbar('Error', 'Registration failed: User with this email or whatsapp already exists');
      }
    } catch (e) {
      print(e.toString());
      // Show error message to user
      Get.snackbar('Error', 'Failed to sign up. Please try again.');
    }
  }

  @override
  void onClose() {
    nameTEController.dispose();
    emailTEController.dispose();
    whatsappTEController.dispose();
    super.onClose();
  }
}