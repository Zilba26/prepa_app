class ScreensManager {
  static bool _loginScreen = true;

  static bool get loginScreen => _loginScreen;

  static void setLoginScreen() {
    _loginScreen = true;
  }

  static void toggleLoginScreen() {
    _loginScreen = !_loginScreen;
  }
}