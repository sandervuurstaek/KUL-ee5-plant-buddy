
import 'package:fl_chart/fl_chart.dart';
import 'package:plantbuddy/widgets/text.dart';

class LineTitles{
  static getTitleData()=> FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
          showTitles: true,
        interval: 8,
        reservedSize: 30,
        getTitlesWidget: (value, titlemate){
            switch(value.toInt()){
              case 0:
                return Header3Text('09:00');
              case 5:
                return Header3Text('10:00');
              case 8:
                return Header3Text('11:00');

            }
            return Header3Text('');
        }


      ),

    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
          showTitles: true,
          interval: 8,
          reservedSize: 30,
          getTitlesWidget: (value, titlemate){

            switch(value.toInt()){
              case 1:
                return Header3Text('10');
              case 3:
                return Header3Text('30');
              case 5:
                return Header3Text('50');

            }
            return Header3Text('');
          }


      ),
    )
  );
}