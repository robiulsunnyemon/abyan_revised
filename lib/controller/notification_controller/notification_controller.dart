
import 'package:get/get.dart';

import '../../api_services/notification_api_services/notification_api_services.dart';
import '../../models/notification_model/notification_model.dart';
import '../../shared_preferences_services/auth_pref_services/auth_pref_services.dart';


class NotificationController extends GetxController {

  var notifications = <AppNotification>[].obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      final response = await NotificationApiService.fetchNotifications();
      if (response.success) {
        notifications.assignAll(response.data.notifications);
      }else{
      }
    } finally {
      isLoading.value = false;
    }
  }




}
