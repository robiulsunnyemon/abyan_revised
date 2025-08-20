import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import '../api_urls/api_urls.dart';

class ResendOTPVerificationApiService{


  static Future<http.Response> resendOTPRequest() async {
    try {
      await AuthPrefService.loadEmail();
      String email = AuthPrefService.userEmail.value;

      final response = await http.post(
        Uri.parse("${ApiUrls.baseUrl}/users/resend-verification-email"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        Get.snackbar("Success", "OTP sent successfully");
      }else{
        Get.snackbar("Error", "Something went wrong ${response.body}");
      }

      return response;
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong $e");
      rethrow;
    }
  }

  static Future<http.Response> forgetPasswordRequest({required String email}) async {
    try {
      print(email);

      final response = await http.post(
        Uri.parse("${ApiUrls.baseUrl}/users/resend-verification-email"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong $e");
      rethrow;
    }
  }

}