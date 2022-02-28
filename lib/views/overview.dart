import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/adaptive_widget.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/todo_list.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';
import 'package:plantbuddy/widgets/weather_card_pageview.dart';

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
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 2, 8, 2),
        child: Header2Text("Weather"),
      ),
      WeatherCardPageView(
        height: 128,
        days: 3,
      ),
    ],
  );
  Widget todo = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 8, 2),
        child: Header2Text("Todo"),
      ),
      const TodoList(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparantAppbar(
        title: "Overview",
      ),
      body: AdaptiveWidget(
          context: context,
          xsmallWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [weather, todo],
          ),
          mediumWidget: Row(
            children: [
              Expanded(
                child: weather,
                flex: 1,
              ),
              Expanded(
                child: todo,
                flex: 2,
              ),
            ],
          )),
    );
  }
}
