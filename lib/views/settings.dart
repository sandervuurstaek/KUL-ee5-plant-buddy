import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';

/// Settings page
///
///
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparantAppbar(
        title: "Settings",
      ),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16),
          child: Header3Text(
            "Under construction",
            textStyle: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
