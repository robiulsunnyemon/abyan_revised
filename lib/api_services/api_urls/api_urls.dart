class ApiUrls{
  static String userID="cmdo1tz8m000jqn0kkijncupz";
  static String baseUrl="https://backend-ab.mtscorporate.com/api";
  static String loginUrl="$baseUrl/users/login";
  static String getProfileInfoUrl="$baseUrl/users/self";
  static String updateProfileInfoUrl="https://backend-ab.mtscorporate.com/api/users/cmdo1tz8m000jqn0kkijncupz";
  static String eventBookUrl="$baseUrl/events/book";
  static String getAllBookingHistoryUrl="$baseUrl/events/history/me";
  static String getAllPastBookingHistoryUrl="$baseUrl/events/history/me/past";
  static String getAllCancelBookingHistoryUrl="$baseUrl/events/history/me/cancelled";
  static String getAllUpcomingBookingHistoryUrl="$baseUrl/events/history/me/upcoming";
  static String getAllMainCategoriesUrl="$baseUrl/categories/main";
  static String getAllSpecificCategoriesUrl="$baseUrl/categories/specific?subCategoryId=";

  static const defaultImageUrl='https://cdn.pixabay.com/photo/2015/12/16/06/03/pixabay-1095454_960_720.jpg';
}
