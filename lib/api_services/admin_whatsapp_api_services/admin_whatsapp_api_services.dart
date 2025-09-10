// services/api_service.dart
import 'dart:convert';
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:http/http.dart' as http;
import '../../models/admin_whatsapp_model.dart';


class ApiService {


  Future<WhatsAppResponse> getWhatsAppInfo() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}/users/admin/whatsapp-number'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WhatsAppResponse.fromJson(data);
      } else {
        throw Exception('Failed to load WhatsApp info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load WhatsApp info: $e');
    }
  }

}