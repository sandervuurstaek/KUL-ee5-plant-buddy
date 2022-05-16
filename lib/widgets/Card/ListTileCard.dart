import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Decoration/CardDecoration.dart';
import '../text.dart';

class ListTileCard extends StatelessWidget {
  Widget leading;
  String text;
   ListTileCard({Key? key ,required this.leading, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.all(4),
      decoration: CardDecoration(16),
      child: Column(
        children: [
          SizedBox(height: 4,),
          Center(
              child: ListTile(
                leading: leading,
                title: Header3Text(text,textStyle: TextStyle(fontWeight: FontWeight.bold ),),
              )
          ),
          SizedBox(height: 4,),
        ],
      ),
    );
  }
}

