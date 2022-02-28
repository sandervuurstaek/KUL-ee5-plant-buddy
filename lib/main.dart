import 'package:flutter/material.dart';
import 'package:plantbuddy/views/home.dart';
import 'package:plantbuddy/ui/startpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Buddy',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(18, 144, 122, 1.0),
      ),
      home: const MyHomePage(title: 'Plant buddy'),
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
  bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    return loggedIn ? const Home() : const Frontpage();
  }
}
