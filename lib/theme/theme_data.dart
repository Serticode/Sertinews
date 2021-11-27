import 'dart:ui';

import 'package:flutter/material.dart';

MyThemeData currentThemeData = MyThemeData();

class MyThemeData with ChangeNotifier {
  static bool _isDarkTheme = false;
  get getCurrentThemeData => _isDarkTheme ? darkTheme : lightTheme;

  void switchTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: "Mohave Regular",
          fontWeight: FontWeight.w700,
          fontSize: 38.0,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16.0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Colors.black12.withOpacity(0.4)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontFamily: "Mohave Regular",
          fontWeight: FontWeight.w700,
          fontSize: 38.0,
          color: Colors.grey.shade800,
        ),
        bodyText2: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700,
          fontSize: 16.0,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

get brightThemeColours => BrightThemeColours();
get darkThemeColours => DarkThemeColours();

class BrightThemeColours {
  static const Color newsFeedColour = Color(0xFF006D77);
  static const Color savedArticlesColour = Color(0xFF4D194D);
  static const Color settingsPageColour = Color(0xFF9E0059);
}

class DarkThemeColours {
  static Color newsFeedColour = Colors.grey.shade200;
  static Color savedArticlesColour = Colors.grey.shade200;
  static Color settingsPageColour = Colors.grey.shade200;
}
