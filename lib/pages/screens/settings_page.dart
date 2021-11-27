import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sertinews/theme/theme_data.dart';
import 'package:sertinews/widgets/other_pages_title.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  double imageContainerMargin = 200.0;
  double imageContainerHeight = 500.0;
  static bool switchPressed = false;
  String _switchValue = "Light Mode";

  //!ANIMATION
  animateImage() {
    Future.delayed(const Duration(milliseconds: 150))
        .then((value) => setState(() {
              imageContainerMargin = 25.0;
              imageContainerHeight = 250.0;
            }));
  }

  @override
  void initState() {
    animateImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //!PAGE TITLE.
          OtherPagesTitle(
            pageTitle: "Settings",
            titleColour: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFF9E0059)
                : Colors.white,
          ),

          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              //!PAGE IMAGE.
              Container(
                padding: const EdgeInsets.all(12.0),
                height: 250,
                decoration: BoxDecoration(
                    color: const Color(0xFF9E0059), // Colors.grey.shade100,
                    image: const DecorationImage(
                      image: AssetImage("assets/settings_page_image.png"),
                      fit: BoxFit.fitHeight,
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

              //!TOGGLES AND PREFERENCES
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //!SECTION TITLE
                      Text("Preferences",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.1,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black87.withOpacity(0.7)
                                        : Colors.grey.shade300,
                                  )),

                      //!TOGGLE

                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        margin: EdgeInsets.only(top: imageContainerMargin),
                        curve: Curves.easeInOutBack,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(_switchValue,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.1,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black87.withOpacity(0.7)
                                            : Colors.grey.shade300,
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
                                  value: switchPressed,
                                  activeColor:
                                      const Color(0xFF006D77).withOpacity(0.2),
                                  inactiveColor: Colors.grey.shade400,
                                  onToggle: ((value) {
                                    setState(() {
                                      switchPressed = value;
                                      value == false
                                          ? _switchValue = "Light Mode"
                                          : _switchValue = "DarkMode";
                                    });
                                    currentThemeData.switchTheme();
                                  })),
                            ]),
                      ),
                    ]),
              )

              //!PAGE BODY
            ]),
          ),
        ],
      ),
    );
  }
}
