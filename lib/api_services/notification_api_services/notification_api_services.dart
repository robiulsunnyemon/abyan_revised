// notification_api_service.dart
import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../models/notification_model/notification_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class NotificationApiService {


 static Future<NotificationResponse> fetchNotifications() async {
   await AuthPrefService.loadToken();
   final token= AuthPrefService.token;

   final response = await http.get(
     Uri.parse('${ApiUrls.baseUrl}/notifications/user'),
     headers: {
       "Content-Type": "application/json",
       "Authorization": "Bearer $token", // if needed
     },
   );

   print("notification response ${response.statusCode}");
   print("notification response ${response.body}");

   if (response.statusCode == 200) {
     return NotificationResponse.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to load notifications');
   }
  }
}
