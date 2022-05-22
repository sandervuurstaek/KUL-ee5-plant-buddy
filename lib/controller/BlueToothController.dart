
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/ActionSheet.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../model/Plant.dart';


class BlueToothController {

  static addNewDevice(BuildContext context) async {
     await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Add New Device",context,
        [ CupertinoActionSheetAction(onPressed:(){
           RouterManager.goBack(context);
           RouterManager.gotoBluetoothSearch(context,true,null);
         } , child: Header3Text("Connect New Device",textStyle: const TextStyle(
           color: Colors.blueAccent,
         ) ))]
     ));
    }

    static configureDeviceWifi(BuildContext context, Plant plant) async {
      await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Configure Wifi",context,
          [ CupertinoActionSheetAction(onPressed:(){
            RouterManager.goBack(context);
            RouterManager.gotoBluetoothSearch(context,false,plant);
          } , child: Header3Text("Select Your Device",textStyle: const TextStyle(
            color: Colors.blueAccent,
          ) ))]
      ));
    }

}
