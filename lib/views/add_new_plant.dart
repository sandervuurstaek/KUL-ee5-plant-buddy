
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/set_plant_parameters.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/text.dart';


class AddNewPlant {

  static Future addNewPlant(BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height / 5,
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
                      'Add New Device',
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
              Divider(height: 1.0),
                Container(
                  margin: EdgeInsets.all(20),
                        child: RoundedButton(data: "Connect New Device", pressed: () async {
                          Navigator.of(context).pop();
                          _setPlantParameters(context);
                        }),
                      )
              ],
            ),
          );
    });
  }
  static Future _setPlantParameters(BuildContext context) async{
    return showModalBottomSheet(
        isScrollControlled: false,
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
