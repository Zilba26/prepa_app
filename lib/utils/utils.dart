import 'package:flutter/material.dart';
import 'package:prepa_app/utils/navigation_service.dart';

class Utils {

  static dynamic getByAdaptiveTheme({required dynamic light, required dynamic dark}) {
    return Theme.of(NavigationService.getContext()).brightness == Brightness.light ? light : dark;
  }
}