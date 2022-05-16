import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:plantbuddy/model/user.dart';
import 'package:plantbuddy/controller/add_new_plant.dart';
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

  Future refresh() async {
      setState(() {
      });
  }

  List<Plant> _getPlantsFromJson(data) {
    List<Plant> plants=[];
    for(var m in data)
    {
      print(m['id']);
      print(m['device_name']);
      print(m['picture']);
      print(m['picture'].toString());
      var image;
      Plant plant;
      if(m['picture']!=null)
        {
         image= Uint8List.fromList(m['picture'].toBytes());
         plant=Plant(PlantID: m['id'], PlantName: m['device_name'],pict: image);
        }
      else
        {
          plant=Plant(PlantID: m['id'], PlantName: m['device_name']);
        }

      plants.add(plant);
    }
    //User().updatedInfo=false;
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
              children: [Icon(Icons.grass_rounded,color: Colors.green,size: 48,),
                SizedBox(width: 4,),
                Header3Text("My Plants",textStyle: TextStyle(fontWeight: FontWeight.bold ),)],
            ),
          ),
          SizedBox(height: 4,),
        ],
      ),
    );


    //when no plants found
    Widget nodataWidget= ListTileCard(leading:Icon(Icons.hourglass_empty_rounded,color: Colors.blue,size: 48,),text:"No Plants Found");


    //when failed to fetch plants
    Widget errorWidget= ListTileCard(leading:Icon(Icons.error_outline_rounded,color: Colors.red,size: 48,),text:"Failed To Fetch Plants");

    return  Scaffold(
          body:
          Column(
            children: [
              head,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: Column(
                    children: [
                      //const SizedBox(height: 30),
                     //User().updatedInfo?
                     FutureBuilder<dynamic>(
                        future: User().getPlants(),
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
                                return nodataWidget;
                              }
                            }
                          else{
                            return Center(child: Loading());
                          }
                        }

                      )/*:Expanded(
                        child: Scrollbar(
                          child: ListView(
                             children:User().plants.map((e) => PlantCard(e)).toList()
                     ),
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => AddNewPlant.addNewPlant(context),
              child: const Icon(Icons.add)),
        );
  }
}
