import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_urls/api_urls.dart';

class OtpVerificationApiServices{

  static Future<http.Response> postOtp({required String otp, required String email}) async {
    Map<String, dynamic> data = {
      "email": email,
      "code": otp,
    };

    try {
      final response = await http.post(
        Uri.parse("${ApiUrls.baseUrl}/users/verify-email"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      return response;
    } catch (e) {
      print("API Error: $e");
      rethrow;
    }
  }

}