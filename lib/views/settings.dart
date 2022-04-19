import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/ProfilePage.dart';
import 'package:plantbuddy/views/accountPage.dart';
import 'package:plantbuddy/widgets/Popwindows.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';
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
  List<Header2Text> languageOptions=[
    Header2Text("English"),
    Header2Text("简体中文（ Simplified Chinese）"),
    Header2Text("Nederlands"),
  ];
  bool notification=true;

  SettingsSection buildSettings()=>SettingsSection(
    title: Header3Text('SETTINGS',
    textStyle: const TextStyle(color: Colors.grey)
    ),
    tiles: <SettingsTile>[
      SettingsTile.navigation(
        title: Header3Text('Profile',
          ),
        trailing: const Icon(Icons.arrow_forward_ios,size: 16,),
        leading: const Icon(Icons.face),
        onPressed: (BuildContext context){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const ProfilePage();
          }));
        },
      ),
      SettingsTile.navigation(
        title:  Header3Text('Account',
        ),
        trailing: const Icon(Icons.arrow_forward_ios,size: 16,),
        leading: const Icon(Icons.account_box),
        onPressed: (BuildContext context){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const accountPage();
          }));
        },
      ),

      SettingsTile.navigation(
        title:  Header3Text('Privacy settings',
        ),
        trailing: Icon(Icons.arrow_forward_ios,size: 16,),
        leading: Icon(Icons.privacy_tip),
        onPressed: (BuildContext context){
        },
      ),
      SettingsTile.switchTile(
        title:  Header3Text('Notifications',
        ),
        leading: Icon(Icons.notification_important),
        onToggle: (value){
          setState(() =>
             notification=value
            );
        },
        initialValue: notification,
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






  @override
  Widget build(BuildContext context) {
   popwindows languagePop=popwindows(languageOptions);
    bool on=true;
    return Scaffold(
      appBar: const TransparantAppbar(
        title: "Settings",
      ),
      body:
      SettingsList(
        brightness: Brightness.light,

          sections: [
            buildSettings(),
            buildHelp()
          ]
        ),
    );
  }
}
