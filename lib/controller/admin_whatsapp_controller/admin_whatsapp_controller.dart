// controllers/whatsapp_controller.dart
import 'package:get/get.dart';
import '../../api_services/admin_whatsapp_api_services/admin_whatsapp_api_services.dart';
import '../../models/admin_whatsapp_model.dart';


class AdminWhatsAppController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var whatsAppResponse = WhatsAppResponse(
    success: false,
    data: WhatsAppData(
      success: false,
      whatsapp: '',
      whatsappLink: '',
    ),
  ).obs;

  var errorMessage = ''.obs;

  // Fetch WhatsApp information
  Future<void> fetchWhatsAppInfo() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await _apiService.getWhatsAppInfo();
      whatsAppResponse(response);

      if (!response.success) {
        errorMessage('Failed to fetch WhatsApp information');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Get WhatsApp number
  String get whatsappNumber => whatsAppResponse.value.data.whatsapp;

  // Get WhatsApp link
  String get whatsappLink => whatsAppResponse.value.data.whatsappLink;

  // Check if data is available
  bool get hasData => whatsAppResponse.value.data.success;

  // Clear error message
  void clearError() {
    errorMessage('');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchWhatsAppInfo();
    super.onInit();
  }
}