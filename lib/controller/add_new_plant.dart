
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/ActionSheet.dart';
import 'package:plantbuddy/widgets/text.dart';


class AddNewPlant {

  static addNewPlant(BuildContext context) async {
     await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Add New Device",context,
        [ CupertinoActionSheetAction(onPressed:(){
           RouterManager.goBack(context);
           RouterManager.gotoBluetoothSearch(context);
         } , child: Header3Text("Connect New Device",textStyle: const TextStyle(
           color: Colors.blueAccent,
         ) ))]
     ));
    }



}
