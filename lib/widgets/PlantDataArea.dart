import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Card/LineChartCard.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../model/user.dart';
import 'Loading.dart';

class PlantDataArea extends StatelessWidget {
  int plantID;
  PlantDataArea({required this.plantID,Key? key}) : super(key: key);

  List<Map<String,dynamic>> _getdatafromJson(data){
    List<Map<String,dynamic>> measurements=[];
    for(var m in data)
      {
        Map<String,dynamic> measurement={"date": m["timestamp"], "value": m["data"]};
        measurements.add(measurement);
      }
    return measurements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<dynamic>(
        future: User().User_get_measurement(plantID),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData)
            {
             return LineChartCard(data: _getdatafromJson(snapshot.data), sensorType: "Temperature");
              //return Center(child: Header3Text("have data"),);
            }
            else if(snapshot.hasError)
            {
              print(snapshot.data);
              return Center(child: Header3Text("have error"),);
            }
            else{
              return Center(child: Header3Text("no data"));
            }
          }
          else{
            return Center(child: Loading());
          }
        },
      ),

    );
  }
}
