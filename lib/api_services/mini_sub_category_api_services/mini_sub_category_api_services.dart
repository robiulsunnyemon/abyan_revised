import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../models/mini_sub_category_model/mini_sub_category_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';



class MiniSubCategoryApiService {


  static Future<SubCategoryFullModel> getMiniSubCategoriesBySubCategory(int subCategoryId) async {
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

      // Extract the miniSubCategory array from the response
      // final List<dynamic> miniSubCategoriesJson = jsonData['data']['miniSubCategory'];



      final jsonData = json.decode(response.body);
      print("Full response: $jsonData");

      final data = jsonData['data'];
      return SubCategoryFullModel.fromJson(data);
    } else {
      print('helllo -------------');
      throw Exception('Failed to load mini sub-categories');
    }
  }

}