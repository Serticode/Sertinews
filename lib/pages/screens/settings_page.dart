import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sertinews/services/settings_provider.dart';
import 'package:sertinews/theme/theme_data.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  double switchContainerMargin = 40.0;
  double chipContainerMargin = 30.0;
  String _switchValue = "Light Mode";

  //!ANIMATION
  animate() {
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => setState(() {
              switchContainerMargin = 5.0;
            }));
  }

  animateChips() {
    Future.delayed(const Duration(milliseconds: 400))
        .then((value) => setState(() {
              chipContainerMargin = 5.0;
            }));
  }

  @override
  void initState() {
    animate();
    animateChips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //!SETTINGS PROVIDER.
    var settingsProvider = Provider.of<SettingsProvider>(context);

    //!TEXT STYLE
    TextStyle _textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black87.withOpacity(0.7)
              : Colors.grey.shade300,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        );

    //!SCREEN SIZE
    Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 28,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF9E0059)
                      : Colors.white,
                  fontWeight: FontWeight.w600,
                )),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          //!PAGE IMAGE.
          Container(
            padding: const EdgeInsets.all(12.0),
            height: _screenSize.height / 2.8,
            decoration: BoxDecoration(
                color: const Color(0xFF9E0059).withOpacity(0.9),
                image: const DecorationImage(
                  image: AssetImage("assets/settings_page_image.png"),
                  fit: BoxFit.contain,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38.withOpacity(0.2),
                    offset: const Offset(
                      0.0,
                      15.0,
                    ),
                    blurRadius: 70.0,
                    spreadRadius: 0.1,
                  ),
                ]),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade200
                      : Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )),
              height: _screenSize.height / 1.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //!DIVIDER
                  const SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    indent: _screenSize.width / 2.4,
                    endIndent: _screenSize.width / 2.4,
                    thickness: 3,
                    color: const Color(0xFF9E0059).withOpacity(0.7),
                  ),

                  //!SECTION TITLE
                  Text(
                    "Preferences",
                    style: _textStyle.copyWith(
                      fontSize: 20.0,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF9E0059)
                          : Colors.white,
                    ),
                  ),

                  //!TOGGLES AND PREFERENCES
                  SizedBox(
                    height: 80,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      margin: EdgeInsets.only(top: switchContainerMargin),
                      curve: Curves.easeInOutBack,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(settingsProvider.theThemeBrightness,
                                style: _textStyle.copyWith(
                                  fontSize: 18.0,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black87.withOpacity(0.7)
                                      : Colors.white,
                                )),
                            FlutterSwitch(
                                inactiveSwitchBorder: Border.all(
                                  color: const Color(0xFF9E0059),
                                  width: 2.0,
                                ),
                                activeSwitchBorder: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                inactiveToggleBorder: Border.all(
                                  color: const Color(0xFF9E0059),
                                  width: 2.0,
                                ),
                                activeToggleBorder: Border.all(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
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
                                value: settingsProvider.theThemeBrightness ==
                                        "Light Mode"
                                    ? false
                                    : true,
                                activeColor:
                                    const Color(0xFF006D77).withOpacity(0.2),
                                inactiveColor: Colors.grey.shade400,
                                onToggle: ((value) {
                                  setState(() {
                                    value == false
                                        ? _switchValue = "Light Mode"
                                        : _switchValue = "Dark Mode";

                                    //!THEME PROVIDER
                                    settingsProvider.setThemeBrightness(
                                        themeBrightness: _switchValue);
                                  });
                                  currentThemeData.switchTheme();
                                })),
                          ]),
                    ),
                  ),

                  //!TITLE
                  Text("News Source",
                      style: _textStyle.copyWith(
                        fontSize: 20.0,
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF9E0059)
                            : Colors.white,
                      )),

                  const SizedBox(
                    height: 10.0,
                  ),

                  Expanded(
                    child: ListView(children: <Widget>[
                      //!FILTER CHIP ROW ONE
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("usa"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      //!IF SETTINGS PROVIDER NEWS SOURCE HAS A LENGTH OF 1
                                      //!EMPTY SETTINGS PROVIDER AND ADD NEW ITEM.

                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "usa");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "usa");
                                      }
                                    } else {
                                      //!VALUE IS FALSE
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "usa");
                                      //!ADD EMPTY STRING TO MAKE SURE SETTINGS PROVIDER IS NOT NULL
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text("The USA", style: _textStyle),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("uk"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "uk");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "uk");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "uk");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text(
                                    "The UK",
                                    style: _textStyle,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("nigeria"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "nigeria");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "nigeria");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "nigeria");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text(
                                    "Nigeria",
                                    style: _textStyle,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                          ]),

                      const SizedBox(
                        height: 10.0,
                      ),

                      //!FILTER CHIP ROW TWO
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("wsj"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "wsj");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "wsj");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "wsj");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text("W.S Journal", style: _textStyle),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("forbes"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "forbes");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "forbes");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "forbes");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text(
                                    "Forbes.com",
                                    style: _textStyle,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                          ]),

                      const SizedBox(
                        height: 10.0,
                      ),

                      //!FILTER CHIP ROW THREE
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("techCrunch"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "techCrunch");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "techCrunch");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "techCrunch");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text("Tech Crunch", style: _textStyle),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 2),
                                margin:
                                    EdgeInsets.only(top: chipContainerMargin),
                                curve: Curves.easeInOutBack,
                                child: FilterChip(
                                  selected: (settingsProvider.theNewsSource
                                          .contains("iphoneHacks"))
                                      ? true
                                      : false,
                                  onSelected: (value) {
                                    if (value == true) {
                                      if (settingsProvider
                                          .theNewsSource.isEmpty) {
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "iphoneHacks");
                                      } else if (settingsProvider
                                              .theNewsSource.length ==
                                          1) {
                                        settingsProvider.theNewsSource.clear();
                                        settingsProvider.addNewsSource(
                                            chosenNewsSource: "iphoneHacks");
                                      }
                                    } else {
                                      settingsProvider.removeNewsSource(
                                          theNewsSource: "iphoneHacks");
                                      settingsProvider.addNewsSource(
                                          chosenNewsSource: "");
                                    }
                                  },
                                  label: Text(
                                    "iPhoneHacks",
                                    style: _textStyle,
                                  ),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ),
                            ),
                          ]),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
