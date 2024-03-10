import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences{

  static saveTheme({required bool isDark}) async {

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
    print('theme saved to isDark: $isDark');
  }

  static Future<bool> getTheme() async {

    final prefs = await SharedPreferences.getInstance();
    print('get theme isDark: ${prefs.getBool('isDark')}');
    return prefs.getBool('isDark') ?? false;
  }
}