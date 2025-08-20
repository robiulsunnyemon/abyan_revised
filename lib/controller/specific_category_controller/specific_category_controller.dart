import 'package:abyansf_asfmanagment_app/api_services/specific_category_api_services/specific_category_api_services.dart';
import 'package:get/get.dart';
import '../../../../models/specific_category_model/specific_category_model.dart';
import '../../view/screens/single_services_pages/specific_category_details_screen.dart';


// class SpecificCategoryController extends GetxController {
//
//
//   var isLoading = false.obs;
//   var subcategory = Rxn<SubCategory>();
//   var specificCategories = <SpecificCategoryWithListings>[].obs;
//   var errorMessage = ''.obs;
//   var sliderIndex=<RxMap<RxInt, RxInt>>[].obs;
//
//   var selectedSliderIndex = 0.obs;
//   changeSliderIndex(int index) {
//     selectedSliderIndex.value=index;
//   }
//
//   Future<void> fetchSubcategoryDetails(int subcategoryId) async {
//     try {
//       isLoading(true);
//       errorMessage('');
//       print("fetch subcategory Details");
//       final response = await SpecificCategoryApiServices.getSubcategoryDetails(subcategoryId);
//       subcategory.value = response.data.subCategory;
//       specificCategories.assignAll(response.data.specificCategories);
//
//       Get.to(()=> SpecificCategoryDetailsScreen());
//     } catch (e) {
//       errorMessage(e.toString());
//       print(e.toString());
//       Get.snackbar('Error', 'Failed to fetch subcategory details: $e');
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   List<Listing> getListingsForSpecificCategory(int specificCategoryId) {
//     final category = specificCategories.firstWhere(
//           (cat) => cat.id == specificCategoryId,
//       orElse: () => SpecificCategoryWithListings(
//         id: -1,
//         name: '',
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//         listings: [],
//       ),
//     );
//     return category.listings;
//   }
// }


class SpecificCategoryController extends GetxController {
  var isLoading = false.obs;
  var subcategory = Rxn<SubCategory>();
  var specificCategories = <SpecificCategoryWithListings>[].obs;
  var errorMessage = ''.obs;

  var sliderIndices = <int, RxInt>{}.obs;


  void changeSliderIndex(int categoryIndex, int newIndex) {
    sliderIndices[categoryIndex]?.value = newIndex;
    update();
  }


  Future<void> fetchSubcategoryDetails(int subcategoryId) async {
    try {
      isLoading(true);
      errorMessage('');
      print("fetch subcategory Details");
      final response = await SpecificCategoryApiServices.getSubcategoryDetails(subcategoryId);
      subcategory.value = response.data.subCategory;
      specificCategories.assignAll(response.data.specificCategories);


      for (int i = 0; i < specificCategories.length; i++) {
        sliderIndices[i] = 0.obs;
      }

      Get.to(()=> SpecificCategoryDetailsScreen());
    } catch (e) {
      errorMessage(e.toString());
      print(e.toString());
      Get.snackbar('Error', 'Failed to fetch subcategory details: $e');
    } finally {
      isLoading(false);
    }
  }

  List<Listing> getListingsForSpecificCategory(int specificCategoryId) {
    final category = specificCategories.firstWhere(
          (cat) => cat.id == specificCategoryId,
      orElse: () => SpecificCategoryWithListings(
        id: -1,
        name: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        listings: [],
      ),
    );
    return category.listings;
  }
}