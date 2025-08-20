import 'package:abyansf_asfmanagment_app/api_services/highlight_api_services/highlight_api_services.dart';
import 'package:get/get.dart';

import '../../models/highlight_model/highlight_model.dart';


class HighlightController extends GetxController {

  final RxList<HighlightItem> highlightsList = <HighlightItem>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchHighlights();
    super.onInit();
  }

  Future<void> fetchHighlights() async {
    try {
      isLoading(true);
      final response = await HighlightApiService.fetchHighlights();
      highlightsList.assignAll(response.data);
      errorMessage('');
    } catch (e) {
      errorMessage('Failed to fetch highlights: $e');
    } finally {
      isLoading(false);
    }
  }
}