import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0.25,
            blurRadius: 20,
            // offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(leading: Header2Text(action,textStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
          SizedBox(height: 4,),
          ListTile(
              title: Header3Text(plantName),
            subtitle: Header3Text(message),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage('asset/plant2.jpg'),
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

