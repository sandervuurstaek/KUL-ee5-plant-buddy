import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:settings_ui/settings_ui.dart';


/// Settings page
///
///
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  SettingsSection buildSettings()=>SettingsSection(
    title: Header3Text('SETTINGS',
    textStyle: const TextStyle(color: Colors.grey)
    ),
    tiles: <SettingsTile>[

      SettingsTile.navigation(
        title:  Header3Text('Account',
        ),
        trailing: const Icon(Icons.arrow_forward_ios,size: 16,),
        leading: const Icon(Icons.account_box),
        onPressed: (BuildContext context){
         RouterManager.gotoAccountPage(context);
        },
      ),
    ],
  );


  SettingsSection buildHelp()=>SettingsSection(
    title: Header3Text('HELP',
        textStyle: TextStyle(color: Colors.grey)
    ),
    tiles: <SettingsTile>[
      SettingsTile.navigation(
        title:  Header3Text('Contact us',
        ),
        leading: Icon(Icons.contact_mail),
        trailing: Icon(Icons.arrow_forward_ios,size: 16,),
        onPressed: (BuildContext context){
        },
      ),
      SettingsTile.navigation(
        title:  Header3Text('About Plant-buddy',
        ),
        leading: Icon(Icons.question_answer_outlined),
        trailing: Icon(Icons.arrow_forward_ios,size: 16,),
        onPressed: (BuildContext context){

        },
      ),

    ],
  );


  SettingsSection buildLogOut(){
    return SettingsSection(tiles: [
      SettingsTile.navigation(
        title: Header3Text('Log Out',
          textStyle: TextStyle(color: Colors.red),
        ),
        leading: Icon(Icons.logout,color: Colors.redAccent,),
        trailing: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.red,),
        onPressed: (BuildContext context){
        RouterManager.toFrontPage(context);
        },
      ),
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SettingsList(
        brightness: Brightness.light,

          sections: [
            buildSettings(),
            buildHelp(),
            buildLogOut(),
          ]
        ),
    );
  }
}
