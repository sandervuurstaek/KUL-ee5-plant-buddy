import 'package:flutter/material.dart';
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
      body: Column(
        children: const [
          Text("test"),
        ],
      ),
    );
  }
}
