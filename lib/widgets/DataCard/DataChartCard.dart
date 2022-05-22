import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/model/Sensor.dart';

import '../../model/Data.dart';

//ignore: must_be_immutable
class DataChart extends StatefulWidget {
  final List<Data> data;
  final String sensorType;
   late double maxX;
   late  double minX;
  final DateTime date;

   List<FlSpot> flSpots=[];

   late double maxY;
   late double minY;


   final double milliseconds_of_a_day=86400000;

   double _getMaxX( ) {   //remove
      List parts2= date.toString().split(" ");
     String day2=parts2.first;
     String timestamp2="${day2} 24:00:00";
     double latesttime=DateTime.parse(timestamp2).millisecondsSinceEpoch.toDouble();
     return latesttime;
   }

   double _getMinX( ) {  //remove
     List parts= date.toString().split(" ");
     String day=parts.first;
     String timestamp="${day} 00:00:00";
     double lasttime=DateTime.parse(timestamp).millisecondsSinceEpoch.toDouble();
     return lasttime;
   }

   double _getMaxValue(List<Data> data){
     if(data.isEmpty)
       {
         return 50;
       }
     return data.map((e) =>e.value).reduce((max, element) {
       if(max >= element){
         return max;
       } else {
         return element;
       }
     });
   }

   double _getMinValue(List<Data> data){
     if(data.isEmpty)
     {
       return 0;
     }
     return data.map((e) =>e.value).reduce((min, element) {
       if(min < element){
         return min;
       } else {
         return element;
       }
     });
   }


   double _getMaxY(List<Data> data){
     double max=_getMaxValue(data);
     double min=_getMinValue(data);
     if((max-min)==0)
     {
       return max+max/8;
     }
     return max+(max-min)/8;
   }

   double _getMinY(List<Data> data){
     double max=_getMaxValue(data);
     double min=_getMinValue(data);
     if((max-min)==0)
       {
         return min/2;
       }
     else if((min-(max-min)/8)>=0)
       {
         return min-(max-min)/8;
       }
     else{
       return 0;
     }
   }


   DataChart({Key? key,required this.data, required this.date, required this.sensorType}) : super(key: key){
     minX= _getMinX();
     maxX = _getMaxX();
     minY=_getMinY(data);
     maxY=_getMaxY(data);
     flSpots=data.map((e) => FlSpot(e.date.millisecondsSinceEpoch.toDouble(),e.value),).toList();
   }

  @override
  _DataChartState createState() => _DataChartState();
}

class _DataChartState extends State<DataChart> {


  String _getTime(String timeStamp){
    return timeStamp.substring(0,10);
  }

  @override
  Widget build(BuildContext context) {
    return
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 400,
              width: 710,
              margin: EdgeInsets.all(
                  8),
              decoration: CardDecoration(16),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
        );
  }



//bottumTile
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      fontSize: 16,
    );
    String content;
    int hour=DateTime.fromMillisecondsSinceEpoch(value.toInt()).hour;
    if(hour%3==0)
      {
        content="${DateTime.fromMillisecondsSinceEpoch(value.toInt()).hour.toString()}:00";
      }
    else{
      content='';
    }
    Widget text=Header6Text(content,textStyle: style,);
    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget topTitleWidget(double value, TitleMeta meta){
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      fontSize: 16,
    );
    Widget text;
    if(DateTime.fromMillisecondsSinceEpoch(value.toInt()).hour==0)
      {
        String content=_getTime(DateTime.fromMillisecondsSinceEpoch(value.toInt()).toString());
        text=Header5Text(content,textStyle: style,);
      }
    else{
      text=Header5Text('');
    }
    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }



//left and right Tile
  Widget leftAndRightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      fontSize: 16,
    );
    String content;
    if(value==widget.maxY)
      {
        content='';
      }
    else if(value==widget.minY)
      {
        content='';
      }
    else{
      content=value.toInt().toString();
    }

     return Container(margin:EdgeInsets.only(left: 8, right: 8),child: Header6Text(content,textStyle: style,));
  }

  LineChartData mainData() {
    return LineChartData(

      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: (widget.maxY-widget.minY)/8,
        verticalInterval: widget.milliseconds_of_a_day/24,
      ),

      titlesData: FlTitlesData(
        show: true,



        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (widget.maxY-widget.minY)/8,
            getTitlesWidget: leftAndRightTitleWidgets,
            reservedSize:40,
          ),
        ),

        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: widget.milliseconds_of_a_day/24,
            getTitlesWidget: topTitleWidget,
            reservedSize:40,
          ),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: (widget.milliseconds_of_a_day)/24,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),

        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (widget.maxY-widget.minY)/8,
            getTitlesWidget: leftAndRightTitleWidgets,
            reservedSize: 40,
          ),
        ),



      ),

     borderData: FlBorderData(
          show:true,
          border: Border.all(color: const Color(0xff37434d), width: 1)
      ),

      minX: widget.minX,

      maxX: widget.maxX,

      minY: widget.minY,

      maxY: widget.maxY,

      lineBarsData: [
        LineChartBarData(
          spots:
            widget.flSpots
          ,
          isCurved: false,

          gradient: LinearGradient(
            colors: Sensor.getSensorGradientColors(widget.sensorType),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),

          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: Sensor.getSensorGradientColors(widget.sensorType)
                  .map((color) => color.withOpacity(0.6))
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