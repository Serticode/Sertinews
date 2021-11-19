//!WIDGET TO SHOW TITLE OF EACH PAGE
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sertinews/theme/theme_data.dart';

class PageTitle extends StatefulWidget {
  final String pageTitle;
  final Color titleColour;
  const PageTitle(
      {Key? key,
      required this.pageTitle,
      required this.titleColour,
      })
      : super(key: key);

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  static bool switchPressed = false;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height / 20,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      title: Text(widget.pageTitle,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 28,
                color: widget.titleColour,
                fontWeight: FontWeight.w600,
              )),
      actions: <Widget>[
        FlutterSwitch(
            inactiveSwitchBorder: Border.all(
              color: widget.titleColour,
              width: 2.0,
            ),
            activeSwitchBorder: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            inactiveToggleBorder: Border.all(
              color: widget.titleColour,
              width: 2.0,
            ),
            activeToggleBorder: Border.all(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF006D77),
              width: 2.0,
            ),
            inactiveIcon: const Icon(
              Icons.nightlight_round_outlined,
              color: Colors.black,
            ),
            activeIcon: const Icon(
              Icons.light_mode_outlined,
              color: Colors.black,
            ),
            value: switchPressed,
            activeColor: const Color(0xFF006D77).withOpacity(0.2),
            inactiveColor: Colors.grey.shade400,
            onToggle: ((value) {
              setState(() {
                switchPressed = value;
              });
              currentThemeData.switchTheme();
            })),
      ],
    );
  }
}
