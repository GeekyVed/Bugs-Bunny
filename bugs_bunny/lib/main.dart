import 'package:bugs_bunny/screens/splash.dart';
import 'package:bugs_bunny/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Tracking System',
      theme: cyberDarkTheme(),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
