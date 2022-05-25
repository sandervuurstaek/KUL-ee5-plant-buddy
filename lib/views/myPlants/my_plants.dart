import 'dart:typed_data';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/model/User.dart';
import 'package:plantbuddy/controller/BlueToothController.dart';
import 'package:plantbuddy/widgets/Card/PlantCard.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/Loading.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../model/Plant.dart';
import '../../widgets/Card/ListTileCard.dart';
import '../../widgets/Toast.dart';

/// Plants page
///
/// Shows all plants registered to the current user
class MyPlants extends StatefulWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {

  Future _refresh() async {
      setState(() {
      });
  }

  List<Plant> _getPlantsFromJson(data) {
    List<Plant> plants=[];
    for(var m in data)
    {
      var image;
      Plant plant;
      if(m['picture']!=null)
        {
         image= Uint8List.fromList(m['picture'].toBytes());
         plant=Plant(PlantID: m['id'], PlantName: m['device_name'],pict: image,api_key: m['api_key'], device_identifier: m['device_identifier']);
        }
      else
        {
          plant=Plant(PlantID: m['id'], PlantName: m['device_name'],api_key: m['api_key'], device_identifier: m['device_identifier']);
          print(m['device_identifier']);
        }

      plants.add(plant);
    }
    return User().plants=plants;
  }

  @override
  Widget build(BuildContext context) {

    Widget head=Container(
      margin:  const EdgeInsets.all(4),
      decoration: CardDecoration(16),
      child: Column(
        children: [
          SizedBox(height: 4,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(CommunityMaterialIcons.sprout,size: 48,color: Theme.of(context).primaryColor,),
                SizedBox(width: 4,),
                Header3Text("My Plants",textStyle: TextStyle(fontWeight: FontWeight.bold ),)],
            ),
          ),
          SizedBox(height: 4,),
        ],
      ),
    );


    //when no plants found
    Widget noDataWidget= ListTileCard(leading:Icon(Icons.hourglass_empty_rounded,color: Colors.blue,size: 48,),text:"No Plants Found");


    //when failed to fetch plants
    Widget errorWidget= ListTileCard(leading:Icon(Icons.error_outline_rounded,color: Colors.red,size: 48,),text:"Failed To Fetch Plants");

    return  Scaffold(
          body:
          Column(
            children: [
              head,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: Column(
                    children: [
                     FutureBuilder<dynamic>(
                        future: User().User_get_Plants(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState==ConnectionState.done)
                            {
                              if(snapshot.hasData)
                              {
                                return Expanded(
                                  child: Scrollbar(child: ListView(
                                    children: _getPlantsFromJson(snapshot.data).map((e) => PlantCard(e)).toList(),
                                  )),
                                );
                              }
                              else if(snapshot.hasError)
                                {
                                  print(snapshot.error);
                                  print(snapshot.stackTrace);
                                  ToastDialog.show_toast(snapshot.error.toString());
                                  return errorWidget;
                                }
                              else{
                                return  noDataWidget;
                              }
                            }
                          else{
                            return Center(child: Loading());
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: !kIsWeb ? FloatingActionButton(
              onPressed: () => BlueToothController.addNewDevice(context),
              child: const Icon(Icons.add)) : null,
        );
  }
}
