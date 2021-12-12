//! THIS FILE HOLDS THE BOTTOM NAV BAR AND CALLS THE SELECT_VIEW CLASS
//! THAT SHOWS DIFFERENT APP VIEWS, BASED ON THE PAGE NUMBER
//! "_currentPageNumber", FOR THE PAGE THE USER SELECTS ON THE BOTTOM NAV BAR.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sertinews/services/settings_provider.dart';
import 'package:sertinews/theme/theme_data.dart';
import 'package:sertinews/widgets/salomon_bottom_bar_files.dart';
import 'package:sertinews/models/page_view_decider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentPageNumber = 0;
  @override
  void initState() {
    super.initState();
    currentThemeData.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var _settingsProvider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _settingsProvider.theThemeBrightness == "Light Mode"
          ? MyThemeData.lightTheme
          : MyThemeData.darkTheme,
      home: Scaffold(
        body: SafeArea(
          child: SelectView(
            pageNumber: _currentPageNumber,
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentPageNumber,
          margin: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 5.0,
            bottom: 8.0,
          ),
          itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          duration: const Duration(milliseconds: 700),
          onTap: (_pageNumber) => setState(() {
            _currentPageNumber = _pageNumber;
          }),
          items: <SalomonBottomBarItem>[
            //!HOME
            SalomonBottomBarItem(
              icon: Icon(_bottomBarIcons[0]),
              activeIcon:
                  Icon(_bottomBarIcons[0], size: _bottomBarSelectedIconSize),
              title: Text(_bottomBarPageTitle[0]),
              selectedColor:
                  (_settingsProvider.theThemeBrightness == "Light Mode")
                      ? BrightThemeColours.newsFeedColour
                      : _selectedBackgroundColourDark,
            ),

            //! SAVED ARTICLES
            SalomonBottomBarItem(
              icon: Icon(_bottomBarIcons[1]),
              title: Text(_bottomBarPageTitle[1]),
              selectedColor:
                  (_settingsProvider.theThemeBrightness == "Light Mode")
                      ? _selectedBackgroundColour[1]
                      : _selectedBackgroundColourDark,
            ),

            //! SETTING
            SalomonBottomBarItem(
              icon: Icon(_bottomBarIcons[2]),
              title: Text(_bottomBarPageTitle[2]),
              selectedColor:
                  (_settingsProvider.theThemeBrightness == "Light Mode")
                      ? _selectedBackgroundColour[2]
                      : _selectedBackgroundColourDark,
            ),
          ],
        ),
      ),
    );
  }

//!NEEDED GETTERS
  get _bottomBarIcons => SalomonBottomBarData().theIcons;
  get _bottomBarPageTitle => SalomonBottomBarData().theNavigationTitle;
  get _bottomBarSelectedIconSize => SalomonBottomBarData().theSelectedIconSize;
  get _selectedBackgroundColour =>
      SalomonBottomBarData().theSelectionBackgroundColours;
  get _selectedBackgroundColourDark =>
      SalomonBottomBarData().theSelectionBackgroundColoursDark;
}
