import 'package:flutter/material.dart';

class MyThemeData {
  final deviceBrightness;
  MyThemeData({required this.deviceBrightness});
}

abstract class BrightThemeColours {
  static const Color newsFeedColour = Color(0xFF006D77);
  static const Color savedArticlesColour = Color(0xFF4D194D);
  static const Color settingsPageColour = Color(0xFF9E0059);
}

class DarkThemeColours {
  static const Color newsFeedColour = Color(0xFF006D77);
  static const Color savedArticlesColour = Color(0xFF4D194D);
  static const Color settingsPageColour = Color(0xFF9E0059);
}
