import 'package:get/get.dart';
import '../../../../api_services/main_category_api_services/main_category_api_services.dart';
import '../../../../models/main_category_model/main_category_model.dart';


class MainCategoryController extends GetxController {


  var isLoading = false.obs;
  var mainCategories = <MainCategory>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMainCategories();
  }

  Future<void> fetchMainCategories() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await MainCategoryApiServices.getMainCategories();
      mainCategories.assignAll(response.data.mainCategories);
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    } finally {
      isLoading(false);
    }
  }

  // Helper methods to get specific categories
  List<SubCategory> getSubCategories(int mainCategoryId) {
    final mainCategory = mainCategories.firstWhere(
          (category) => category.id == mainCategoryId,
      orElse: () => MainCategory(
        id: -1,
        name: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        subCategories: [],
      ),
    );
    return mainCategory.subCategories;
  }

  List<SpecificCategory> getSpecificCategories(int subCategoryId) {
    for (var mainCategory in mainCategories) {
      for (var subCategory in mainCategory.subCategories) {
        if (subCategory.id == subCategoryId) {
          return subCategory.specificCategories;
        }
      }
    }
    return [];
  }
}