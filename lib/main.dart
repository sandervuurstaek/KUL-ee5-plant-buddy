import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:plantbuddy/controller/auth_manager.dart';
import 'package:plantbuddy/views/home.dart';
import 'package:plantbuddy/views/startpage.dart';

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
        primarySwatch:
            generateMaterialColor(const Color.fromRGBO(18, 144, 122, 1.0)),
      ),
      home: ValueListenableBuilder(
        valueListenable: AuthManager.loggedInNotifier,
        builder: (context, bool loggedIn, _) =>
            loggedIn ? const Home() : const Frontpage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return loggedIn ? const Home() : const Frontpage();
  }
}

