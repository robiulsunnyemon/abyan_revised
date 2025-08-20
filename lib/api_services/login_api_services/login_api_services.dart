import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:http/http.dart' as http;

class LoginApiServices {
  static Future<dynamic> loginPostRequest({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrls.loginUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
          "rememberMe": true,
        }),
      );
      return response;
    } catch (e) {
      return e.toString();
    }
  }
}
