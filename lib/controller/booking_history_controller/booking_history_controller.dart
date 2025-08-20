import 'package:get/get.dart';
import '../../../../api_services/booking_history_api_services/booking_history_api_services.dart';
import '../../../../models/booking_history_model/booking_history_model.dart';


class EventBookingController extends GetxController {


  var isLoading = false.obs;
  var bookingsAll = <Booking>[].obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
   fetchUserAllBookings();
    super.onInit();
  }

  Future<void> fetchUserAllBookings() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventBookingApiService.getUserBookings();
      if (result.success) {
        bookingsAll.value = result.data.bookings;
      } else {

      }
    } catch (e) {
      print(e.toString());
      errorMessage(e.toString());
      bookingsAll.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserAllPastBookings() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventBookingApiService.getPastBookingsHistory();
      if (result.success) {
        bookingsAll.clear();
        bookingsAll.value = result.data.bookings;
        update();
      } else {

      }
    } catch (e) {
      print(e.toString());
      errorMessage(e.toString());
      bookingsAll.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserAllCancelBookings() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventBookingApiService.getCancelBookingsHistory();
      if (result.success) {
        bookingsAll.clear();
        bookingsAll.value = result.data.bookings;
        update();
      } else {

      }
    } catch (e) {
      print(e.toString());
      errorMessage(e.toString());
      bookingsAll.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserAllActiveBookings() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await EventBookingApiService.getActiveBookingsHistory();
      if (result.success) {
        bookingsAll.clear();
        bookingsAll.value = result.data.bookings;
        update();
      } else {

      }
    } catch (e) {
      print(e.toString());
      errorMessage(e.toString());
      bookingsAll.clear();
    } finally {
      isLoading(false);
    }
  }
}