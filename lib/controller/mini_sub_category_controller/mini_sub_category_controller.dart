// lib/controllers/mini_sub_category_controller.dart
/*
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
      print('result----------$result');
      miniSubCategories.assignAll(result);
      Get.to(()=>MiniSubCategoryScreen(subCategoryId: subCategoryId,));
    } catch (e) {
      print("mini sub category error $e");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}*/
import 'package:abyansf_asfmanagment_app/view/screens/single_services_pages/mini_sub_category_screen.dart';
import 'package:get/get.dart';
import '../../api_services/mini_sub_category_api_services/mini_sub_category_api_services.dart';
import '../../models/mini_sub_category_model/mini_sub_category_model.dart';

class MiniSubCategoryController extends GetxController {
  var isLoading = false.obs;

  // পুরো data রাখবে
  var subCategoryData = Rxn<SubCategoryFullModel>();

  // শুধু mini sub category list access করার জন্য
  var miniSubCategories = <MiniSubCategory>[].obs;

  // নির্বাচিত sub category
  var selectedMiniSubCategory = Rxn<MiniSubCategory>();

  Future<void> fetchMiniSubCategories(int subCategoryId) async {
    try {
      isLoading(true);

      final result = await MiniSubCategoryApiService.getMiniSubCategoriesBySubCategory(subCategoryId);

      // result এখন SubCategoryFullModel টাইপের
      subCategoryData.value = result;
      miniSubCategories.assignAll(result.miniSubCategory);

      print('✅ Fetched SubCategory: ${result.name}');
      print('✅ Mini SubCategories: ${result.miniSubCategory.length} items');

      Get.to(() => MiniSubCategoryScreen(subCategoryId: subCategoryId));
    } catch (e) {
      print("❌ mini sub category error $e");
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
