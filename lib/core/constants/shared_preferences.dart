// import 'dart:developer';

// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefsData {
//   static const String _isRememberUserKey = 'is_remember_user';
//   static const String _tokenKey = 'user_token';
//   static const String _userEmail = 'user_email';

//   static Future<void> saveUserToken({required String? token}) async {
//     final prefs = await SharedPreferences.getInstance();

//     log('stored token is $token');

//     if (token != null) {
//       await prefs.setString(_tokenKey, token);
//     }
//   }

//   static Future<void> rememberUser(
//       {required String? token, required String? email}) async {
//     final prefs = await SharedPreferences.getInstance();

//     // bool isRememberUser = token != null && token.isNotEmpty;
//     bool saveEmail =
//         token != null && token.isNotEmpty && email != null && email.isNotEmpty;

//     if (saveEmail) {
//       await prefs.setString(_userEmail, email);
//       // await prefs.setBool(_isRememberUserKey, isRememberUser);
//     }
//   }

//   static Future<bool> isRememberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_isRememberUserKey) ?? false;
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   static Future<String?> getEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userEmail);
//   }

//   static Future<void> clearSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_isRememberUserKey);
//     await prefs.remove(_tokenKey);
//     await prefs.remove(_userEmail);
//   }
//   static Future<void> clearEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userEmail);
//   }
// }
