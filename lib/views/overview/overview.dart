import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Card/PlantLogCard.dart';
import 'package:plantbuddy/widgets/adaptive_widget.dart';
import 'package:plantbuddy/widgets/weather_card_pageview.dart';

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


    Widget plantLogInfo =  RefreshIndicator(child: Scrollbar(child: ListView(
      reverse: true,
      children: [
        const PlantLogCard("Water","Plant1","The temperature is too high up to 36 degree"),
        PlantLogCard("Progress update","Plant2","Message2"),
        PlantLogCard("Progress update","Plant3","Message3"),
        PlantLogCard("Progress update","Plant2","Message2"),
        PlantLogCard("Progress update","Plant3","Message3"),
        PlantLogCard("Progress update","Plant2","Message2"),
        PlantLogCard("Progress update","Plant3","Message3"),
      ],
    )), onRefresh:_refresh );


    return Scaffold(
      body: AdaptiveWidget(
          context: context,
          xsmallWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              weather,
              Container(margin: EdgeInsets.all(8),child: Header6Text("Plants Log Information",textStyle: TextStyle(color: Colors.grey),)),
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
