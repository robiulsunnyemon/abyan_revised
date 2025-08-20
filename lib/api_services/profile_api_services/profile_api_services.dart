import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../view/widget/custom_bottom_bar.dart';

class ProfileApiServices {
  static Future<dynamic> getUserProfile() async {
    try {
      await AuthPrefService.loadToken();
      final token = AuthPrefService.token;

      final response = await http.get(
        Uri.parse(ApiUrls.getProfileInfoUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("profile response data ${response.statusCode}");
      print("profile response data ${response.body}");
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> updateUserProfile({required Map<String,dynamic> data}) async {
    await AuthPrefService.loadToken();
    await AuthPrefService.loadUid();
    final uid = AuthPrefService.uid;
    final token = AuthPrefService.token;
    try {
      final response = await http.put(
        Uri.parse("${ApiUrls.baseUrl}/users"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(data),
      );
      print("update body: ${jsonEncode({"name": data["name"], "whatsapp": data["whatsapp"]})}");
      print("profile update response body ${response.body}");
      print("profile update response status code ${response.statusCode}");
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> uploadImage({File? imageFile}) async {
    if (imageFile == null) return false;

    await AuthPrefService.loadToken();
    await AuthPrefService.loadUid();
    final uid = AuthPrefService.uid;
    final token = AuthPrefService.token;

    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${ApiUrls.baseUrl}/users'),
    );

    // Add headers if needed
    request.headers['Authorization'] = 'Bearer $token';

    // Add image file
    var file = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    // Send request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      return true;
    } else {
      return false;
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }
}
