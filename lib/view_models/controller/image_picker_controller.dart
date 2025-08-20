import 'dart:io';
import 'package:abyansf_asfmanagment_app/api_services/profile_api_services/profile_api_services.dart';
import 'package:abyansf_asfmanagment_app/controller/profile_controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/widget/custom_bottom_bar.dart';

class ImagePickerController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);

  final _profileController=Get.put(ProfileController());


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      print("selected image ${selectedImage.value}");
      final response = await ProfileApiServices.uploadImage(imageFile: selectedImage.value);
      if(response){
        _profileController.fetchUserProfile();
        Get.to(()=>CustomBottomBar());
      }

    }
  }
}
