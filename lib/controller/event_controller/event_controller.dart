import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api_services/event_api_services/event_api_services.dart';
import '../../../../models/event_upcoming_model/event_upcoming_model.dart';

class EventController extends GetxController {


  var isLoading = false.obs;
  var upcomingEvents = <Event>[].obs;
  var pastEvents = <Event>[].obs;
  var pagination = Pagination(page: 1, limit: 10, total: 0, pages: 1).obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    fetchUpcomingEvents();
    fetchPastEvents();
    super.onInit();
  }

  Future<void> fetchUpcomingEvents({int page = 1}) async {
    try {
      isLoading(true);
      errorMessage('');

      final result = await EventApiService.getUpcomingEvents(
        page: page,
        limit: pagination.value.limit,
      );



      upcomingEvents.assignAll(result.data.events);
      pagination(result.data.pagination);
    } catch (e) {
      errorMessage(e.toString());
      upcomingEvents.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> upcomingRefreshEvents() async {
    await fetchUpcomingEvents();
  }

  Future<void> upcomingLoadMoreEvents() async {
    if (pagination.value.page < pagination.value.pages && !isLoading.value) {
      await fetchUpcomingEvents(page: pagination.value.page + 1);
    }
  }


  //past event

  Future<void> fetchPastEvents({int page = 1}) async {
    try {
      isLoading(true);
      errorMessage('');

      final result = await EventApiService.getPastEvents(
        page: page,
        limit: pagination.value.limit,
      );



      pastEvents.assignAll(result.data.events);
      pagination(result.data.pagination);
    } catch (e) {
      errorMessage(e.toString());
      upcomingEvents.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> pastRefreshEvents() async {
    await fetchPastEvents();
  }

  Future<void> pastLoadMoreEvents() async {
    if (pagination.value.page < pagination.value.pages && !isLoading.value) {
      await fetchPastEvents(page: pagination.value.page + 1);
    }
  }


  Future<void> bookEvent({
    required int eventId,
  }) async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventApiService.bookEvent(
        eventId: eventId,
      );

      if(result){
        Get.snackbar(
          'Success',
          'Event booked successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }else {
        Get.snackbar(
          'Error',
          'You have already booked this event',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }

  }




  Future<bool> deleteEvent({
    required int eventId,
  }) async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventApiService.deleteEvent(
        eventId: eventId,
      );

      if(result){
        Get.snackbar(
          'Success',
          'Booked Event deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }else {
        Get.snackbar(
          'Error',
          'You have already deleted booked this event',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return result;
      } catch (e) {
        errorMessage(e.toString());
        return false;
      }
  }



}