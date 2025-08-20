import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefService {
  static final RxString token = ''.obs;
  static const String _tokenKey = 'auth_token';

  static final RxString uid = ''.obs;
  static const String _uidKey = 'auth_uid';

  static final RxString userEmail = ''.obs;
  static const String _userEmail = 'auth_email';

  static final RxString userName = ''.obs;
  static const String _userName = 'auth_name';

  // Private constructor to prevent instantiation
  AuthPrefService._();

  /// Initializes the token from SharedPreferences
  static Future<void> init() async {
    await loadToken();
  }

  /// Saves the token to SharedPreferences
  static Future<void> saveToken(String newToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, newToken);
      token.value = newToken;
    } catch (e) {
      _handleError('Error saving token', e);
    }
  }

  /// Loads the token from SharedPreferences
  static Future<void> loadToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString(_tokenKey) ?? '';
      token.value = storedToken;
    } catch (e) {
      _handleError('Error loading token', e);
    }
  }

  /// Clears the token from SharedPreferences
  static Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      token.value = '';
    } catch (e) {
      _handleError('Error clearing token', e);
    }
  }

  /// Checks if a token exists
  static bool hasToken() {
    loadToken();
    loadUid();
    loadEmail();
    loadUserName();
    print(token.value);
    return token.value.isNotEmpty;
  }

  /// Gets the current token
  static String getCurrentToken() {
    return token.value;
  }

  /// Handles errors consistently
  static void _handleError(String message, dynamic error) {
    // You can replace this with your preferred error handling
    // e.g., logging, showing a snackbar, etc.
    print('$message: $error');
    // Optional: Show error to user
    Get.snackbar('Error', message);
  }



  /// Saves the uid to SharedPreferences
  static Future<void> saveUid(String uiD) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_uidKey, uiD);
      uid.value = uiD;
    } catch (e) {
      _handleError('Error saving token', e);
    }
  }

  /// Loads the uid from SharedPreferences
  static Future<void> loadUid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUid = prefs.getString(_uidKey) ?? '';
      uid.value = storedUid;
    } catch (e) {
      _handleError('Error loading token', e);
    }
  }

  /// Saves the user email to SharedPreferences
  static Future<void> saveEmail(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userEmail, email);
      userEmail.value = email;
    } catch (e) {
      _handleError('Error saving token', e);
    }
  }


  /// Loads the email from SharedPreferences
  static Future<void> loadEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserEmail = prefs.getString(_userEmail) ?? '';
      userEmail.value = storedUserEmail;
    } catch (e) {
      _handleError('Error loading token', e);
    }
  }


  /// Saves the user email to SharedPreferences
  static Future<void> saveUserName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userName, name);
      userName.value = name;
    } catch (e) {
      _handleError('Error saving token', e);
    }
  }

  static Future<void> loadUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserName = prefs.getString(_userName) ?? '';
      userName.value = storedUserName;
    } catch (e) {
      _handleError('Error loading token', e);
    }
  }

}