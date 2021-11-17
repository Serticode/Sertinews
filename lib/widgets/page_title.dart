//!WIDGET TO SHOW TITLE OF EACH PAGE
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sertinews/theme/theme_data.dart';

class PageTitle extends StatefulWidget {
  final String pageTitle;
  final Color titleColour;
  final IconData pageIcon;
  const PageTitle(
      {Key? key,
      required this.pageTitle,
      required this.titleColour,
      required this.pageIcon})
      : super(key: key);

  @override
  State<PageTitle> createState() => _PageTitleState();
}

class _PageTitleState extends State<PageTitle> {
  static bool switchPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      height: MediaQuery.of(context).size.height / 12,
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(widget.pageTitle,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 24,
                    color: widget.titleColour,
                    fontWeight: FontWeight.w600,
                  )),
          FlutterSwitch(
              inactiveSwitchBorder: Border.all(
                color: widget.titleColour,
                width: 2.0,
              ),
              activeSwitchBorder: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              showOnOff: true,
              inactiveIcon: const Icon(Icons.nightlight_round_outlined),
              activeIcon: const Icon(
                Icons.light_mode_outlined,
                color: Colors.black,
              ),
              value: switchPressed,
              activeColor: widget.titleColour,
              inactiveColor: Colors.grey.shade400,
              onToggle: ((value) {
                setState(() {
                  switchPressed = value;
                });
                currentThemeData.switchTheme();
              })),
        ],
      ),
    );
  }
}
