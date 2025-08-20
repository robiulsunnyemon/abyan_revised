// lib/controllers/mini_sub_category_controller.dart
import 'package:abyansf_asfmanagment_app/view/screens/single_services_pages/mini_sub_category_screen.dart';
import 'package:get/get.dart';
import '../../api_services/mini_sub_category_api_services/mini_sub_category_api_services.dart';
import '../../models/mini_sub_category_model/mini_sub_category_model.dart';

class MiniSubCategoryController extends GetxController {
  var isLoading = false.obs;
  var miniSubCategories = <MiniSubCategory>[].obs;
  var selectedMiniSubCategory = Rxn<MiniSubCategory>();

  Future<void> fetchMiniSubCategories(int subCategoryId) async {
    try {
      isLoading(true);
      final result = await MiniSubCategoryApiService.getMiniSubCategoriesBySubCategory(subCategoryId);
      miniSubCategories.assignAll(result);
      Get.to(()=>MiniSubCategoryScreen());
    } catch (e) {
      print("mini sub category error $e");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}