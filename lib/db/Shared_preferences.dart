// import 'package:shared_preferences/shared_preferences.dart';
// class MySharedPreferences{
// static SharedPreferences? _preferences;
// static const String key='usertype';
//
// static init() async{
//   _preferences = await SharedPreferences.getInstance();
//   return _preferences;
// }
//  static Future saveUserType(String type) async{
//  return await _preferences!.setString(key, type);
// }
// static Future<String>? getUserType()async => await _preferences!.getString(key) ?? "";
//
// static Future<void> clearAll() async {
//   await _preferences?.clear();
// }
//
// }
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {

  static SharedPreferences? _preferences;
  static const String key = 'usertype';
  static const String emailKey = "email"; // ✅ ADDED


  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //Saving the current User
  static Future<bool> saveUserType(String type) async {
    return await _preferences!.setString(key, type);
  }

  /// 🔴 Get User Type
  static Future<String> getUserType() async {
    return _preferences?.getString(key) ?? "";
  }

  static Future<bool> saveUserEmail(String email) async {
    return await _preferences!.setString(emailKey, email);
  }

  static String? getUserEmail() {
    return _preferences?.getString(emailKey);
  }

  // Clear All data
  static Future<void> clearAll() async {
    await _preferences?.clear();
  }
}