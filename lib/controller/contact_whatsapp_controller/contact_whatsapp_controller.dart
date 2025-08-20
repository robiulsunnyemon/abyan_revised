import 'package:get/get.dart';
import '../../api_services/contact_whatsapp_api_services/contact_whatsapp_api_services.dart';
import '../../models/contact_whats_model/contact_whatsapp_model.dart';
import '../../view/screens/main_screen/message_screen.dart';


class ContactWhatsappController extends GetxController {


  var isLoading = false.obs;
  var serviceData = Rxn<ContactWhatsappData>();
  var errorMessage = ''.obs;

  Future<void> fetchServiceDetails(int serviceId) async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ContactWhatsappApiService.getServiceDetails(serviceId);
      serviceData.value = response.data;
      if(response.success){
        Get.to(() => MassageScreen());
      }else{
        Get.snackbar('Error', 'Failed to fetch service details: ${response.data}');
      }
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to fetch service details: $e');
    } finally {
      isLoading(false);
    }
  }


}