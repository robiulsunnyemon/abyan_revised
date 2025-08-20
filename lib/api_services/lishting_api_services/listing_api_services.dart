import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/listting_details_model/listing_details_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';



class ListingApiServices {


 static Future<ListingDetailResponse> getListingDetails(int listingId) async {
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
        return ListingDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load listing details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load listing details: $e');
    }
  }
}