import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/specific_category_model/specific_category_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class SpecificCategoryApiServices  {

 static Future<SubcategoryDetailResponse> getSubcategoryDetails(int subcategoryId) async {
    try {
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.get(
        Uri.parse('${ApiUrls.getAllSpecificCategoriesUrl}$subcategoryId'), // Replace with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("from specific ${response.statusCode}");

      if (response.statusCode == 200) {
        return SubcategoryDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load subcategory details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subcategory details: $e');
    }
  }
}