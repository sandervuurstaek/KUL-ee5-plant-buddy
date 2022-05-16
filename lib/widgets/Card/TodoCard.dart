import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';

class TodoCard extends StatelessWidget {
  final String action;
  final String plantName;
  final String message;

  const TodoCard(this.action,this.plantName, this.message,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: CardDecoration(24),
      child: Column(
        children: [
          ListTile(leading: Header3Text(action,textStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
          ListTile(
              title: Header3Text(plantName),
            subtitle: Header3Text(message),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('asset/plant5.jpg'),
            ),
            trailing: Icon(Icons.water_drop, color: Colors.blueAccent,),
              onTap:(){

              }
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}

