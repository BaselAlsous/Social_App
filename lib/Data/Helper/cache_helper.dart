// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreference;

  static init() async {
    print('The Helper Function is init');
    return sharedPreference = await SharedPreferences.getInstance();
  }

  static dynamic getdata({
    required String key,
  }) {
    return sharedPreference?.get(key);
  }

  static Future setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreference?.setString(key, value);
    } else if (value is int) {
      return await sharedPreference?.setInt(key, value);
    } else if (value is double) {
      return await sharedPreference?.setDouble(key, value);
    } else if (value is bool) {
      return await sharedPreference?.setBool(key, value);
    }
  }
}
