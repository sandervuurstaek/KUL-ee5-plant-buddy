import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/text.dart';
import '../widgets/transparant_appbar.dart';

class accountPage extends StatefulWidget {
  const accountPage({Key? key}) : super(key: key);

  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {

  SettingsSection buidAccountPage(){
    return SettingsSection(
      title: Header3Text('SETTINGS',
          textStyle: TextStyle(color: Colors.grey)
      ),
        tiles:
        [SettingsTile.navigation(
          title: Header3Text('Password',
          ),
          trailing: Icon(Icons.arrow_forward_ios,size: 16,),
          leading: Icon(Icons.lock),
          onPressed: (BuildContext context){
          },
        ),
        ]
    );
  }

  SettingsSection buildDeleteAccount(){
    return SettingsSection(tiles: [
      SettingsTile.navigation(
        title: Header3Text('Delete account and all data',
          textStyle: TextStyle(color: Colors.redAccent),
        ),
        leading: Icon(Icons.logout,color: Colors.redAccent,),
        onPressed: (BuildContext context){
        },
      ),
    ]);
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
            buildDeleteAccount()
          ]
      ),
    );;;
  }
}
