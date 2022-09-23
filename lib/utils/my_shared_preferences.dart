import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late bool _isConnected;
  static String? _username;
  static late AdaptiveThemeMode _themeMode;

  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("isConnected") == null) {
      prefs.setBool("isConnected", false);
    }
    _isConnected = prefs.getBool("isConnected")!;
    if (_isConnected) _username = prefs.getString("username");

    if (prefs.getString("themeMode") == null) {
      prefs.setString("themeMode", "dark");
    }
    _themeMode = prefs.getString("themeMode") == "dark" ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
  }

  static bool get isConnected => _isConnected;
  static String? get username => _username;
  static AdaptiveThemeMode get themeMode => _themeMode;

  static connexion(String username, bool remember) async {
    if (remember) {
      await prefs.setBool("isConnected", true);
      await prefs.setString("username", username);
    }
    _isConnected = true;
    _username = username;
  }

  static deconnexion() async {
    await prefs.setBool("isConnected", false);
    await prefs.remove('username');
    _isConnected = false;
    _username = null;
  }

  static setLight() async {
    await prefs.setString("themeMode", "light");
    _themeMode = AdaptiveThemeMode.light;
  }

  static setDark() async {
    await prefs.setString("themeMode", "dark");
    _themeMode = AdaptiveThemeMode.dark;
  }
}