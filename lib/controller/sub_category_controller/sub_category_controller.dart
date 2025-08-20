import 'package:get/get.dart';
import '../../api_services/sub_category_api_services/sub_category_api_services.dart';
import '../../models/sub_category_model/subcategory_model.dart';


class SubCategoryController extends GetxController {

  var isLoading = false.obs;
  var subCategories = <SubCategory>[].obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    fetchSubCategories();
    super.onInit();
  }

  Future<void> fetchSubCategories() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await SubCategoryApiService.getSubCategories();


      // Clear existing data
      subCategories.clear();

      // Add new data - using spread operator for safety
      subCategories.addAll(response.data.subCategories);

    } catch (e) {

      errorMessage(e.toString());
      Get.snackbar(
        'Error',
        'Failed to fetch subcategories',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}