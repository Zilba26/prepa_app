import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:prepa_app/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late bool _isConnected;
  static Profile? _profile;
  static late AdaptiveThemeMode _themeMode;

  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("isConnected") == null) {
      prefs.setBool("isConnected", false);
    }
    _isConnected = prefs.getBool("isConnected")!;
    if (_isConnected) {
      final String username = prefs.getString("username")!;
      final String email = prefs.getString("email")!;
      final String id = prefs.getString("id")!;
      _profile = Profile(username: username, email: email, id: id);
    }

    if (prefs.getString("themeMode") == null) {
      prefs.setString("themeMode", "dark");
    }
    _themeMode = prefs.getString("themeMode") == "dark" ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light;
  }

  static bool get isConnected => _isConnected;
  static String? get username => _profile?.username;
  static AdaptiveThemeMode get themeMode => _themeMode;

  static Future<void> connexion(Profile profile, bool remember) async {
    if (remember) {
      await prefs.setBool("isConnected", true);
      await prefs.setString("username", profile.username);
      await prefs.setString("email", profile.email);
      await prefs.setString("id", profile.id);
    }
    _isConnected = true;
    _profile = profile;
  }

  static Future<void> deconnexion() async {
    await prefs.setBool("isConnected", false);
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('id');
    _isConnected = false;
    _profile = null;
  }

  static Future<void> setLight() async {
    await prefs.setString("themeMode", "light");
    _themeMode = AdaptiveThemeMode.light;
  }

  static Future<void> setDark() async {
    await prefs.setString("themeMode", "dark");
    _themeMode = AdaptiveThemeMode.dark;
  }
}