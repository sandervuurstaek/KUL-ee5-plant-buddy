import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';

class actionSheet extends CupertinoActionSheet{
  final String header;
  BuildContext context;
  List<Widget> actionOptions;
  actionSheet(this.header, this.context,this.actionOptions , {Key? key}): super(
    key: key,
    title: Header3Text(header,textStyle: const TextStyle(
      color: Color.fromRGBO(72, 75, 75, 1.0),
      fontWeight: FontWeight.bold,
    ),),
    actions: actionOptions,
    cancelButton: CupertinoActionSheetAction(onPressed: ()=>Navigator.of(context).pop() ,child: Header3Text("Cancel",textStyle: const TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
    ),),),
  );

}
