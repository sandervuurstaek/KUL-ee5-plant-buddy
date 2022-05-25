import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/model/Notification.dart';
import 'package:plantbuddy/widgets/Card/NotificationCard.dart';
import 'package:plantbuddy/widgets/adaptive_widget.dart';
import 'package:plantbuddy/widgets/weather_card_pageview.dart';

import '../../model/User.dart';
import '../../widgets/Card/ListTileCard.dart';
import '../../widgets/Loading.dart';
import '../../widgets/Toast.dart';
import '../../widgets/text.dart';

/// Overview page
///
/// Shows the weather and a todo list
class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Widget weather = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      WeatherCardPageView(
        height: 128,
        days: 3,
      ),
    ],
  );

  Future _refresh() async {
    setState(() {
    });
  }




  @override
  Widget build(BuildContext context) {


    List<Message> _getNotificationsFromJson(data) {
      List<Message> messages=[];
      for(var m in data)
      {
        Message  message=Message(id: m['id'], type: m['notification_id'], plantName: m['device_name'], timeStamp: m['time_stamp']);
        messages.add(message);
      }
      return messages;
    }


    //when no notification found
    Widget noDataWidget= ListTileCard(leading:Icon(CommunityMaterialIcons.sprout,
      color: Colors.lightGreenAccent,size: 48,),
        text:"Your notification is empty");


    //when failed to fetch notifications
    Widget errorWidget= ListTileCard(leading:Icon(Icons.error_outline_rounded,color: Colors.red,size: 48,),text:"Failed To Fetch Plants");

    Widget plantLogInfo =  RefreshIndicator(child:
        FutureBuilder<dynamic>(
            future: User().UserGet_notifications(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.done)
              {
                if(snapshot.hasData)
                {
                  return ListView(reverse: false,
                  children: _getNotificationsFromJson(snapshot.data).map((e) => NotificationCard( notification: e)).toList(),
                  );
                }
                else if(snapshot.hasError)
                {
                  print(snapshot.error);
                  print(snapshot.stackTrace);
                  ToastDialog.show_toast(snapshot.error.toString());
                  return errorWidget;
                }
                else{
                  return  noDataWidget;
                }
              }
              else{
                return Center(child: Loading());
              }
            }
        ),
        onRefresh:_refresh
    );



    return Scaffold(
      body: AdaptiveWidget(
          context: context,
          xsmallWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              weather,
              Container(margin: EdgeInsets.all(8),child: Header6Text("Plants Notification",textStyle: TextStyle(color: Colors.grey),)),
              Expanded(
                child: plantLogInfo,
              ),],
          ),
          mediumWidget: Row(
            children: [
              Expanded(
                child: weather,
                flex: 1,
              ),
              Expanded(
                child: plantLogInfo,
                flex: 2,
              ),
            ],
          )),
    );
  }
}
