import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/main_category_model/main_category_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class MainCategoryApiServices{


  static Future<CategoryResponse> getMainCategories() async {
    try {
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.get(
        Uri.parse(ApiUrls.getAllMainCategoriesUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        return CategoryResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}