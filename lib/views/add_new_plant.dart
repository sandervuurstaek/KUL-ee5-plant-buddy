
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/set_plant_parameters.dart';
import 'package:plantbuddy/widgets/ActionSheet.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/text.dart';

import 'FindDevice.dart';


class AddNewPlant {

  static addNewPlant(BuildContext context) async {
     await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Add New Device",context,
        [ CupertinoActionSheetAction(onPressed:(){
           Navigator.of(context).pop();
           Navigator.push(context, MaterialPageRoute(builder: (context) {
             return  BlueToothSearch(context);
           }));
         } , child: Header3Text("Connect New Device",textStyle: const TextStyle(
           color: Colors.blueAccent,
         ) ))]
     ));
    }


  static Future _setPlantParameters(BuildContext context) async{
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(32.0),
                topRight: const Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Stack(
                    textDirection: TextDirection.rtl,
                    children: [
                      Center(
                        child: Header3Text(
                          'Plant parameters',
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextInButton(

                          data: 'Done', pressed: () {
                        Navigator.of(context).pop();
                      }
                      ),
                    ],
                  ),
                ),
                Divider(height: 1.0),
                Container(
                  child:
                  SetPlantParameters(),
                ),
              ],
            ),
          );
        });

  }
}
