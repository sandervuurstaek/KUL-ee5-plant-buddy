import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../model/user.dart';
import '../../widgets/text.dart';
import '../../widgets/transparant_appbar.dart';

class accountPage extends StatefulWidget {
  const accountPage({Key? key}) : super(key: key);

  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {

  SettingsSection buidAccountPage(){
    return SettingsSection(
      title: Header3Text('Account Profile',
          textStyle: TextStyle(color: Colors.grey)
      ),
        tiles:
        [SettingsTile.navigation(
          title: Header3Text(User().firstname,textStyle: TextStyle(color: Colors.black),
          ),
          description: Header5Text("First Name",textStyle: TextStyle(color: Colors.grey)),
          leading: Icon(Icons.person,color: Colors.red,size: 48,),
        ),
          SettingsTile.navigation(
            title: Header3Text(User().lastname,textStyle: TextStyle(color: Colors.black),
            ),
            description: Header5Text("Last Name",textStyle: TextStyle(color: Colors.grey)),
            leading: Icon(Icons.person,color: Colors.blueAccent,size: 48,),
          ),
          SettingsTile.navigation(
            title: Header3Text(User().email,textStyle: TextStyle(color: Colors.black),
            ),
            description: Header5Text("Email",textStyle: TextStyle(color: Colors.grey)),
            leading: Icon(Icons.email,color: Colors.yellow,size: 48,),
          ),
        ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparantAppbar(
        title: "Account",
      ),
      body:
      SettingsList(
          sections: [
            buidAccountPage(),
          ]
      ),
    );;;
  }
}
