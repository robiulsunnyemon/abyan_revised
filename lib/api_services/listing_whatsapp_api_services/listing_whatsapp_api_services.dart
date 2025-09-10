import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../controller/listing_whatsapp_controller/listing_whatsapp_controller.dart';
import '../../models/listing_whatsapp_model/listing_whatsapp_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class ListingWhatsappApiServices{


  static Future<ListingWhatsappModel?> fetchListingWhatsapp(int listingId) async {
    try {
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/listings/$listingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("listing response status code ${response.statusCode}");
      print("listing response status body: ${response.body}");
      if (response.statusCode == 200) {
        return ListingWhatsappModel.fromJson(jsonDecode(response.body));
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }



}