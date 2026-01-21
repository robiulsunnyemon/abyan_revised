
import 'package:abyansf_asfmanagment_app/api_services/api_urls/api_urls.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/mini_sub_whatsapp_model/mini_sub_whatsapp_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';
import '../../view/screens/single_services_pages/mini_sub_whatsappApi_services_screen.dart';

class ServiceController extends GetxController {
  var isLoading = false.obs;
  var serviceData = Rxn<ServiceData>();
  var errorMessage = ''.obs;

  // Fetch service details by ID
  Future<void> fetchServiceDetails(int miniSubCategory , int index) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await AuthPrefService.loadToken();
      final token= AuthPrefService.token;

      final url = '${ApiUrls.baseUrl}/categories/mini-sub/$miniSubCategory'; // replace with your API
      final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          }

      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        serviceData.value = ServiceResponse.fromJson(jsonResponse).data;
        Get.to(()=>MiniWhatsappMessageScreen(index: index,));
      } else {
        print(response.statusCode);
        print(response.body);
        errorMessage.value = 'Failed to load service details';
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
