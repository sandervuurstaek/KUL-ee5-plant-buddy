import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';

class LineChartCard extends StatefulWidget {
  List<Map<String,dynamic>> data;
  String sensorType;
  LineChartCard({required this.data, required this.sensorType,Key? key}) : super(key: key);

  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  late List<FlSpot> flSpots;
  List<Color> gradientColors = [
    const Color(0xffa5091a),
    const Color(0xfff0f6f5),
  ];
  
   List<FlSpot> toTimeSeriesFlSpots( ){
    if(widget.data.isEmpty) return [];
     return widget.data.map((e) => FlSpot(DateTime.parse(e["date"]).millisecondsSinceEpoch.toDouble(), e["value"].toDouble())).toList();
  }

  double getminX(){
    if(widget.data.isEmpty) {
      return DateTime.now().millisecondsSinceEpoch.toDouble()-Duration.microsecondsPerDay;
    } else{
      List parts= widget.data[0]["date"].toString().split(" ");
      String day=parts.first;
      String timestamp="${day} 00:00:00";
      return DateTime.parse(timestamp).millisecondsSinceEpoch.toDouble();
    }
  }

  double getmaxX(){
     if(widget.data.isEmpty) {
       return DateTime.now().millisecondsSinceEpoch.toDouble();
     } else{
       List parts= widget.data[widget.data.length-1]["date"].toString().split(" ");
       String day=parts.first;
       String timestamp="${day} 23:59:59";
       return DateTime.parse(timestamp).millisecondsSinceEpoch.toDouble();
     }
  }




  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
       AspectRatio(
         aspectRatio: 1,
         child: Container(
              margin: EdgeInsets.all(4),
              decoration: CardDecoration(16),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: Column(
                  children: [
                    Center(child: Header4Text(widget.sensorType),),
                     LineChart(
                        mainData(),
                      ),

                  ],
                ),
              ),
            ),
       ),

      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
    );
    Widget text;
   // final DateTime date=DateTime.fromMillisecondsSinceEpoch(value.toInt());
   // final parts = date.toIso8601String().split("T");
    //text=Header5Text(parts.last);
    switch (value.toInt()) {
      case 4:
        text =  Header4Text('MAR', textStyle: style);
        break;
      case 8:
        text = Header4Text('JUN', textStyle: style);
        break;
      case 12:
        text = Header4Text('SEP', textStyle: style);
        break;
      case 16:
        text = Header4Text('SEP', textStyle: style);
        break;
      default:
        text =  Header5Text('', textStyle: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
    );
    String text;
   /* switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }*/
    text=value.toInt().toString();
    return Header4Text(text, textStyle: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        drawHorizontalLine: true,
        drawVerticalLine: true,
        show: true,
       horizontalInterval: 1,
        verticalInterval: 1,
       /* getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },*/
       /* getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },*/
      ),


      titlesData: FlTitlesData(
        show: true,
        
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 4,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 20,
          ),
        ),
      ),



      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)
      ),

      minX: 0,
      maxX: 20,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
         // toTimeSeriesFlSpots(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.4))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }

}