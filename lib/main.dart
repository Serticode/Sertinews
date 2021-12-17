import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sertinews/pages/screens/splash_screen.dart';
import 'package:sertinews/services/settings_provider.dart';
import 'pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash());
          } else {
            // Loading is done, return the app:
            return ChangeNotifierProvider(
                create: (BuildContext context) => SettingsProvider(),
                child: const Wrapper());
          }
        });
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 5));
  }
}
