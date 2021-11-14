import 'package:flutter/material.dart';

class SalomonBottomBarData {
  get theIcons => _icons;
  get theSelectedIconSize => _selectedIconSize;
  get theNavigationTitle => _navigationTitle;
  get theSelectionBackgroundColours => _selectionBackgroundColours;

  //!SALOMON NAV BAR ICONS
  final List<IconData> _icons = const [
    Icons.home_outlined,
    Icons.bookmark_add_outlined,
    Icons.settings_outlined,
  ];

  //!SIZE OF SALOMON NAV BAR SELECTED ICON
  final double _selectedIconSize = 26.0;

  //!TITLE OF SALOMON NAV BAR ICON
  final List<String> _navigationTitle = const [
    "Home",
    "Saved Articles",
    "Settings",
  ];

  //!COLOUR OF SALOMON NAV BAR SELECTION BACKGROUND
  final List<Color> _selectionBackgroundColours = const [
    Color(0xFF006D77),
    Color(0xFF4D194D),
    Color(0xFF9E0059),
  ];
}
