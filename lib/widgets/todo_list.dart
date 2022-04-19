import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';

/// List of things the user should do to increase the health of the plant
class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 0.25,
              blurRadius: 20,
             // offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CommunityMaterialIcons.leaf, color: Colors.green,size: 64,),
            Header3Text(
              "All tasks completed",
              textStyle: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(
              width: 8,
            ),
            Icon(CommunityMaterialIcons.sleep, color: Colors.grey[700]),
          ],
        ),
      ),
    );
  }
}
