import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Header3Text("Update your location?",textStyle: const TextStyle(
        color: Color.fromRGBO(72, 75, 75, 1.0),
        fontWeight: FontWeight.bold,
      ),),
      actions: [
        CupertinoActionSheetAction(onPressed: (){}, child: Header3Text("Yes, update my location")),
      ],
      cancelButton: CupertinoActionSheetAction(onPressed: ()=>Navigator.of(context).pop(),child: Header3Text("Cancel",textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),),),
    );
  }
}
