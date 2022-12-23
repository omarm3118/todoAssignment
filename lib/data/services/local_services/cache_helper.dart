import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setTheme({required bool isDark}) async {
    return await _preferences.setBool('isDark', isDark);
  }

  static bool? get getThemeIsDark {
    return _preferences.getBool('isDark');
  }
}
