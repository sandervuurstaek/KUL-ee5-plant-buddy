import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/LineTitles.dart';

class LineChartWidget extends StatelessWidget {

  final List<Color> gradientColors =[
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  LineChartWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        //titlesData: LineTitles.getTitleData(),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: Colors.grey,
              strokeWidth: 3
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine:  (value){
      return FlLine(
      color: Colors.grey,
      strokeWidth: 3
      );
      },
        ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey, width: 3),


          ),

        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 2.5),
              FlSpot(8, 4),
              FlSpot(9.5, 3),
              FlSpot(11, 4),
            ],
            gradient: LinearGradient(colors: gradientColors),
            isCurved: true,
            barWidth: 5,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(colors: gradientColors.map((color) => color.withOpacity(0.3)).toList()),


            )

          )
        ]


      )
    );
  }
}
