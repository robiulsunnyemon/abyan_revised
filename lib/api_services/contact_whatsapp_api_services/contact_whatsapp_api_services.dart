import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/contact_whats_model/contact_whatsapp_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class ContactWhatsappApiService {


  static Future<ContactWhatsappResponse> getServiceDetails(int subCategoryId) async {

    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/categories/sub/$subCategoryId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Service Details Response: ${response.body}');
      print('Service Details Response: ${response.statusCode}');
      if (response.statusCode == 200) {
        return ContactWhatsappResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load service details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load service details: $e');
    }
  }




}