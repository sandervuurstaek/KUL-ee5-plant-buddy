import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/add_new_plant.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';

/// Plants page
///
/// Shows all plants registered to the current user
class MyPlants extends StatefulWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> with SingleTickerProviderStateMixin{
  int? selectedValue=0;
  Map<int, Widget> children = <int, Widget>{
    0: Column(children: [Icon(Icons.home),Header3Text("Sites",textStyle: TextStyle(color: Colors.black))]),
    1: Column(children: [Icon(Icons.grass),Header3Text("Plants",textStyle: TextStyle(color: Colors.black))],),
  };

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: const TransparantAppbar(
            title: "My Plants",
          ),
          body:
          Column(
            children: [
              Container(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor: Colors.white,
                  thumbColor: Theme.of(context).primaryColor,
                   groupValue: selectedValue,
                    children: children,
                    onValueChanged: (int?value){
                      setState(() {
                        selectedValue=value;
                      });
                    },

                    ),
              ),
              SizedBox(height: 30),
              Container(
                child: selectedValue==0?FutureBuilder(
                  future: null,
                  builder: (context, snapshot) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Header3Text(
                      "You don't have any sites added",
                      textStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ):FutureBuilder(
                  future: null,
                  builder: (context, snapshot) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Header3Text(
                      "You don't have any plants monitored yet",
                      textStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
              )

            ],
          ),



          /*FutureBuilder(
            future: null,
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(16),
              child: Header3Text(
                "You don't have any plants monitored yet",
                textStyle: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),*/
          floatingActionButton: FloatingActionButton(
              onPressed: () async => AddNewPlant.addNewPlant(context),
              child: const Icon(Icons.add)),
        );
  }
}
