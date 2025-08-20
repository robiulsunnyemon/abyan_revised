import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../models/mini_sub_category_model/mini_sub_category_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';



class MiniSubCategoryApiService {


  static Future<List<MiniSubCategory>> getMiniSubCategoriesBySubCategory(int subCategoryId) async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/categories/sub/$subCategoryId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("sub category mini response ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Extract the miniSubCategory array from the response
      final List<dynamic> miniSubCategoriesJson = jsonData['data']['miniSubCategory'];
      return miniSubCategoriesJson.map((json) => MiniSubCategory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mini sub-categories');
    }
  }

}