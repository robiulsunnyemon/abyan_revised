import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:abyansf_asfmanagment_app/shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import 'package:http/http.dart' as http;

import '../../models/booking_history_model/booking_history_model.dart';


class EventBookingApiService {


  static Future<BookingModel> getUserBookings() async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    final response = await http.get(
      Uri.parse(ApiUrls.getAllBookingHistoryUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load bookings');
    }
  }


  static Future<BookingModel> getPastBookingsHistory() async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;
    final response = await http.get(
      Uri.parse(ApiUrls.getAllPastBookingHistoryUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load bookings');
    }
  }


  static Future<BookingModel> getCancelBookingsHistory() async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    final response = await http.get(
      Uri.parse(ApiUrls.getAllCancelBookingHistoryUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  static Future<BookingModel> getActiveBookingsHistory() async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;
    final response = await http.get(
      Uri.parse(ApiUrls.getAllCancelBookingHistoryUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return BookingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load bookings');
    }
  }



}