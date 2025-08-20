import 'package:get/get.dart';
import 'package:abyansf_asfmanagment_app/view_models/controller/image_picker_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePickerController>(() => ImagePickerController());
    // Get.put(DateController());
    // Get.put(CarouselSliderControllers());
    // Get.put(CounterController());
    // Get.put(RecoveryVerificationController());
    // Get.put(VerificationController());
    // Get.put(ProfileController());
    // Get.put(SubCategoryController());
    // Get.put(EventController());
    // Get.put(ListingDetailController());
  }
}
