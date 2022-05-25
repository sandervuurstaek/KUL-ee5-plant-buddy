import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../controller/RouterManager.dart';
import '../../model/User.dart';
import '../ActionSheet.dart';
import 'package:plantbuddy/model/Notification.dart';


class NotificationCard extends StatefulWidget {
  final Message notification;
  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool loading=false;


  _enterLoading(){
    setState(() {
      loading=true;
    });
  }

  _leaveLoading(){
    setState(() {
      loading=false;
    });
  }


  _deleteThisLog(BuildContext context) async {
    await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Delete this Notification?",context,
        [ CupertinoActionSheetAction(onPressed:() async {
          _enterLoading();
          await User().User_delete_notification(widget.notification.id);
          _leaveLoading();
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
          ListTile(leading: Header3Text(widget.notification.plantName,textStyle: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
            trailing: Header5Text(widget.notification.timeStamp, textStyle: TextStyle(color: Colors.grey),),
          ),
          ListTile(
            title: Header3Text(widget.notification.notification),
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


