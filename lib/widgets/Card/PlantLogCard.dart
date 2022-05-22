import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../controller/RouterManager.dart';
import '../ActionSheet.dart';

class PlantLogCard extends StatelessWidget {
  final String action;
  final String plantName;
  final String message;

  const PlantLogCard(this.action,this.plantName, this.message,{Key? key}) : super(key: key);


   _deleteThisLog(BuildContext context) async {
    await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Delete this log ?",context,
        [ CupertinoActionSheetAction(onPressed:(){
          RouterManager.toHomepage(context);
        } , child: Header3Text("Delete",textStyle: const TextStyle(
          color: Colors.red,
        ) ))]
    ));
  }

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
            trailing: IconButton(icon: Icon(Icons.not_started_rounded,color: Colors.lightBlueAccent,size: 36,),onPressed: (){
              _deleteThisLog(context);
            },),
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}

