import 'package:flutter/material.dart';
import 'package:prepa_app/home.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext getContext() {
    BuildContext context = StatefulElement(const Home());
    if (navigatorKey.currentContext != null) {
      context = navigatorKey.currentContext!;
    }
    return context;
  }
}