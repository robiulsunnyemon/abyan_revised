import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/sub_category_model/subcategory_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class SubCategoryApiService {

 // static Future<SubCategoryModel> getSubCategories() async {
 //    try {
 //      await AuthPrefService.loadToken();
 //      final token= AuthPrefService.token;
 //
 //      final response = await http.get(
 //        Uri.parse('${ApiUrls.baseUrl}/categories/sub'),
 //        headers: {
 //          'Content-Type': 'application/json',
 //          'Authorization': 'Bearer $token',
 //        },
 //
 //      );
 //
 //      if (response.statusCode == 200) {
 //        print("sub category response: ${response.body}");
 //        return SubCategoryModel.fromJson(json.decode(response.body));
 //      } else {
 //        throw Exception('Failed to load subcategories');
 //      }
 //    } catch (e) {
 //      throw Exception('Error: $e');
 //    }
 //  }



  static Future<SubCategoryModel> getSubCategories() async {
    try {
      await AuthPrefService.loadToken();
      final token = AuthPrefService.token;

      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/categories/sub?limit=1000'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("sub category response: ${response.body}");

        final List subCategories = data['data']['subCategories'];

        const wantedNames = [
          'Restaurants',
          'Beach Clubs',
          'Luxury Yachts',
        ];

        // Match case-insensitively and tolerate small name differences
        final filtered = subCategories.where((item) {
          final name = item['name']?.toString().toLowerCase() ?? '';
          return wantedNames.any((wanted) =>
              name.contains(wanted.toLowerCase()));
        }).toList();

        // Overwrite with filtered data
        data['data']['subCategories'] = filtered;

        return SubCategoryModel.fromJson(data);
      } else {
        throw Exception('Failed to load subcategories (status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}