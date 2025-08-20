import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:http/http.dart' as http;

class RegistrationApiServices {


  static Future<dynamic> signupRequest({required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiUrls.baseUrl}/users/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      return e.toString();
    }
  }
}
