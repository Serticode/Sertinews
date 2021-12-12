import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sertinews/services/settings_provider.dart';
import 'pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => SettingsProvider(),
        child: const Wrapper());
  }
}
