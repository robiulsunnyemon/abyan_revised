import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/service_booking_model/service_booking_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';



class ServicesBookingApiService{

 static Future<ServiceBookingModel> getServiceBookings() async {
    try {
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/sub-category-bookings/grouped/self?page=1&limit=50'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("service booking history ${response.statusCode}");
      if (response.statusCode == 200) {
        return ServiceBookingModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load service bookings');
      }
    } catch (e) {
      throw Exception('Error fetching service bookings: $e');
    }
  }

}