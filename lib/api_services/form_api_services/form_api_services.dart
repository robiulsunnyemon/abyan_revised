import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import '../api_urls/api_urls.dart';

class FormRequestApiServices{


  static Future<dynamic> formRequest({ required Map<String,dynamic> data ,required String url}) async {
    try {

      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.post(
        Uri.parse("${ApiUrls.baseUrl}/$url"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"

        },
        body: jsonEncode(data),
      );
      return response;
    } catch (e) {
      print("error form request: ${e.toString()}");
      return e.toString();
    }
  }

}