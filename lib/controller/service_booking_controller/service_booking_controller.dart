import 'package:get/get.dart';
import '../../api_services/service_booking_api_services/service_booking_api_services.dart';
import '../../models/service_booking_model/service_booking_model.dart';


class ServicesBookingController extends GetxController {
  // Observable list to store all bookings
  var allBookings = <Booking>[].obs;
  var pendingBookings = <Booking>[].obs;
  var confirmedBookings = <Booking>[].obs;
  var completedBookings = <Booking>[].obs;
  var cancelledBookings = <Booking>[].obs;

  Rx<String> statusType='All'.obs;

  void changeStatusType(String value){
    statusType.value=value;
    update();
  }

  // Loading states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Pagination info
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var itemsPerPage = 10.obs;

  @override
  void onInit() {
    fetchServiceBookings();
    super.onInit();
  }

  Future<void> fetchServiceBookings() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ServicesBookingApiService.getServiceBookings();

      if (response.success) {
        // Update all lists
        allBookings.assignAll(response.data.all);
        pendingBookings.assignAll(response.data.pending);
        confirmedBookings.assignAll(response.data.confirmed);
        completedBookings.assignAll(response.data.complete);
        cancelledBookings.assignAll(response.data.cancelled);

        // Update pagination info
        currentPage(response.data.pagination.page);
        itemsPerPage(response.data.pagination.limit);
        totalPages(response.data.pagination.pages.all);
      } else {
        errorMessage('Failed to load bookings');
      }
    } catch (e) {
      errorMessage('Error: ${e.toString()}');
      Get.snackbar('Error', 'Failed to fetch service bookings: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Filter bookings by type
  List<Booking> getBookingsByType(String type) {
    switch (type.toLowerCase()) {
      case 'all':
        return allBookings;
      case 'pending':
        return pendingBookings;
      case 'confirmed':
        return confirmedBookings;
      case 'completed':
        return completedBookings;
      case 'cancelled':
        return cancelledBookings;
      default:
        return allBookings;
    }
  }

  // Get booking by ID
  Booking? getBookingById(int id) {
    try {
      return allBookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update booking status
  Future<void> updateBookingStatus(int bookingId, String newStatus) async {
    try {
      // Find the booking
      final bookingIndex = allBookings.indexWhere((b) => b.id == bookingId);
      if (bookingIndex == -1) return;

      // Create a new booking with updated status
      final updatedBooking = Booking(
        id: allBookings[bookingIndex].id,
        type: allBookings[bookingIndex].type,
        userId: allBookings[bookingIndex].userId,
        status: newStatus,
        createdAt: allBookings[bookingIndex].createdAt,
        updatedAt: DateTime.now(),
        bookingInfo: allBookings[bookingIndex].bookingInfo,
        subCategory: allBookings[bookingIndex].subCategory,
        miniSubCategory: allBookings[bookingIndex].miniSubCategory,
        listing: allBookings[bookingIndex].listing,
        mainCategory: allBookings[bookingIndex].mainCategory,
        user: allBookings[bookingIndex].user,
      );

      // Update in all lists
      allBookings[bookingIndex] = updatedBooking;

      // Remove from old status list and add to new status list
      _updateStatusLists(updatedBooking);

      // Here you would typically also call an API to update on server
      // await ServicesBookingApiService.updateBookingStatus(bookingId, newStatus);

      Get.snackbar('Success', 'Booking status updated to $newStatus');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update booking status: ${e.toString()}');
    }
  }

  // Helper method to manage status lists
  void _updateStatusLists(Booking booking) {
    // Remove from all status lists
    pendingBookings.removeWhere((b) => b.id == booking.id);
    confirmedBookings.removeWhere((b) => b.id == booking.id);
    completedBookings.removeWhere((b) => b.id == booking.id);
    cancelledBookings.removeWhere((b) => b.id == booking.id);

    // Add to the appropriate list
    switch (booking.status.toLowerCase()) {
      case 'pending':
        pendingBookings.add(booking);
        break;
      case 'confirmed':
        confirmedBookings.add(booking);
        break;
      case 'complete':
        completedBookings.add(booking);
        break;
      case 'cancelled':
        cancelledBookings.add(booking);
        break;
    }
  }

  // Refresh data
  Future<void> refreshBookings() async {
    await fetchServiceBookings();
  }
}