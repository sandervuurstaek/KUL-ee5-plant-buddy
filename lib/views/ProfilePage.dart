
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/IndoorOrOutdoor.dart';
import 'package:plantbuddy/views/chooseSkillLevel.dart';
import 'package:plantbuddy/widgets/ActionSheet.dart';
import 'package:plantbuddy/widgets/loading.dart';
import 'package:plantbuddy/widgets/locationText.dart';
import 'package:settings_ui/settings_ui.dart';
import '../controller/location_handler.dart';
import '../widgets/text.dart';
import '../widgets/transparant_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  FutureBuilder getlocation(BuildContext context){
    return FutureBuilder(
    future: LocationHandler.getCurrentLocation(),
        builder: (BuildContext context, location) =>
    !location.hasData?Container(width: 10,height: 10, child: Loading(),)
        :location.data == null
        ?Container(width: 10,height: 10, child: Loading(),):
        LocationText(lat: location.data!.latitude ?? 0, lon: location.data!.longitude ?? 0)
    );
  }

  SettingsSection buidProfile(){
    return SettingsSection(
      tiles:
      [SettingsTile.navigation(
        leading: Icon(Icons.gps_fixed_rounded),
        trailing: Icon(Icons.arrow_forward_ios,size: 16,),
     title: Header3Text('Location',
      textStyle: TextStyle(fontWeight: FontWeight.bold,),
    ),
    value: getlocation(context),
    onPressed: (BuildContext context) async {
         var thing= await showCupertinoModalPopup(context: context, builder: (context)=>ActionSheet());
    },
    ),
    SettingsTile.navigation(
    leading: Icon(Icons.cloud_circle_outlined),
      trailing: Icon(Icons.arrow_forward_ios,size: 16,),
    title:  Header3Text('Indoor/Outdoor',
    textStyle: TextStyle(fontWeight: FontWeight.bold,),
    ),
    onPressed: (BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const IndoorOrOutdoorPage(mode: "Settings");
      }));
    },
    ),
    SettingsTile.navigation(
    leading: Icon(Icons.local_activity_rounded),
    trailing: Icon(Icons.arrow_forward_ios,size: 16,),
    title:  Header3Text('Skill Level',
    textStyle: TextStyle(fontWeight: FontWeight.bold,),
    ),
    onPressed: (BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const ChooseSkillLevel(mode: "Settings");
      }));
    },
    ),
    SettingsTile.navigation(
    leading: Icon(Icons.balcony),
      trailing: Icon(Icons.arrow_forward_ios,size: 16,),
    title:  Header3Text('Sites',
    textStyle: TextStyle(fontWeight: FontWeight.bold,),
    ),
    onPressed: (BuildContext context){
    },
    ),]
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparantAppbar(
        title: "Profile",
      ),
      body:
      SettingsList(
          sections: [
            buidProfile(),
          ]
      ),
    );;
  }
}



