import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../models/event_upcoming_model/event_upcoming_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';

class EventApiService {


  static Future<EventUpcomingModel> getUpcomingEvents({
    int page = 1,
    int limit = 10,
  }) async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/events/upcoming?limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return EventUpcomingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load events');
    }
  }





  static Future<EventUpcomingModel> getPastEvents({
    int page = 1,
    int limit = 10,
  }) async {
    await AuthPrefService.loadToken();
    final token= AuthPrefService.token;

    final response = await http.get(
      Uri.parse('${ApiUrls.baseUrl}/events/past?limit=$limit'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("past event response");

    print(response.statusCode);

    if (response.statusCode == 200) {
      return EventUpcomingModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load events');
    }
  }



  static Future<bool> bookEvent({
    required int eventId,
  }) async {
    try{
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.post(
        Uri.parse(ApiUrls.eventBookUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'eventId': eventId,}),
      );
      if(response.statusCode==201){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }




  static Future<bool> deleteEvent({
    required int eventId,
  }) async {

    try{

      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final response = await http.delete(
        Uri.parse('${ApiUrls.baseUrl}/events/booking/$eventId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }



}