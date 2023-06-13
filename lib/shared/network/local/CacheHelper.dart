import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<Future<bool>?> putBooleen({
    required String key,
    required bool value,
  }) async{
    return sharedPreferences?.setBool(key, value);
  }

  static bool? getBooleen({
   required String key,
}) {
    return sharedPreferences?.getBool(key);
  }
}
