import 'package:flutter/material.dart';
//import 'package:sertinews/widgets/page_title.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
                Text("SETTINGS PAGE"),

        /* PageTitle(
          pageTitle: "Settings",
          titleColour: Color(0xFF9E0059),
        ) */
      ],
    );
  }
}
