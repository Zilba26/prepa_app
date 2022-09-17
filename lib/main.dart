import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'navigation_service.dart';
import 'utils/my_shared_preferences.dart';
import 'home.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await MySharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: MySharedPreferences.themeMode,
      light: ThemeData(
        brightness: Brightness.light,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
      ),
      builder: (theme, darkTheme) => MaterialApp(
          title: 'Prepa App',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          theme: theme,
          darkTheme: darkTheme,
          home: const Home()
      ),
    );
  }
}
