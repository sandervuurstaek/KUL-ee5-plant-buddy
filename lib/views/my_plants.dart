import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/views/add_new_plant.dart';
import 'package:plantbuddy/widgets/PlantCard.dart';
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: const TransparantAppbar(
            title: "My Plants",
          ),
          body:
          Column(
            children: [
              const SizedBox(height: 30),
              FutureBuilder(
                future: null,
                builder: (context, snapshot) => PlantCard(
                    "Flower",
                  ),

              ),
              PlantCard("Aloe vera"),
              PlantCard("Kloe vera"),

            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () => AddNewPlant.addNewPlant(context),
              child: const Icon(Icons.add)),
        );
  }
}
