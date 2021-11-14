import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sertinews/constants/salomon_bottom_bar_files.dart';
import 'package:sertinews/models/page_view_decider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  get _bottomBarIcons => SalomonBottomBarData().theIcons;
  get _bottomBarPageTitle => SalomonBottomBarData().theNavigationTitle;
  get _bottomBarSelectedIconSize => SalomonBottomBarData().theSelectedIconSize;
  get _selectedBackgroundColour =>
      SalomonBottomBarData().theSelectionBackgroundColours;

  int _currentPageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SelectView(pageNumber: _currentPageNumber,),
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
          debugPrint(_currentPageNumber.toString());
        }),
        items: <SalomonBottomBarItem>[
          //!HOME
          SalomonBottomBarItem(
            icon: Icon(_bottomBarIcons[0]),
            activeIcon:
                Icon(_bottomBarIcons[0], size: _bottomBarSelectedIconSize),
            title: Text(_bottomBarPageTitle[0]),
            selectedColor: _selectedBackgroundColour[0],
          ),

          //! SAVED ARTICLES
          SalomonBottomBarItem(
            icon: Icon(_bottomBarIcons[1]),
            title: Text(_bottomBarPageTitle[1]),
            selectedColor: _selectedBackgroundColour[1],
          ),

          //! SETTING
          SalomonBottomBarItem(
            icon: Icon(_bottomBarIcons[2]),
            title: Text(_bottomBarPageTitle[2]),
            selectedColor: _selectedBackgroundColour[2],
          ),
        ],
      ),
    );
  }
}
