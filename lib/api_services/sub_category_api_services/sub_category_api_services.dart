import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/sub_category_model/subcategory_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class SubCategoryApiService {

 static Future<SubCategoryModel> getSubCategories() async {
    try {
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/categories/sub'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },

      );

      if (response.statusCode == 200) {

        return SubCategoryModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}