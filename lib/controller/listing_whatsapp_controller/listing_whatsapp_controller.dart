import 'package:get/get.dart';

import '../../api_services/listing_whatsapp_api_services/listing_whatsapp_api_services.dart';
import '../../models/listing_whatsapp_model/listing_whatsapp_model.dart';
import '../../view/screens/main_screen/message_screen_for_listing.dart';


class ListingWhatsappController extends GetxController {
  var isLoading = false.obs;
  var listingData = Rxn<ListingWhatsappModel>();


  void fetchListingWhatsapp(int listingId) async {
    isLoading.value = true;
    var result = await ListingWhatsappApiServices.fetchListingWhatsapp(listingId);
    if (result != null) {
      listingData.value = result;
      Get.to(()=>MessageScreenForListing());
    }
    isLoading.value = false;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    listingData.close();
    super.onClose();
  }
}
