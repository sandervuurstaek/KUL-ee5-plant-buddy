import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
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

class _MyPlantsState extends State<MyPlants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparantAppbar(
        title: "My Plants",
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder(
        future: null,
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16),
          child: Header3Text(
            "You don't have any plants monitored yet",
            textStyle: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
