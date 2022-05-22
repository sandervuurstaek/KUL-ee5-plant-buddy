import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/model/Data.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/model/Sensor.dart';
import '../Decoration/CardDecoration.dart';

class SensorCard extends StatefulWidget {
  final Widget leading;
  final String sensorType;
  final Color color;
  final List<Data> data;
  const SensorCard({Key? key, required this.leading, required this.sensorType, required this.color, required this.data}) : super(key: key);

  @override
  _SensorCardState createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {

  _getCurrentValue()
  {
    return widget.data[0].value.toString();
  }

  _getCurrentDate(){
    return widget.data[0].timeStamp.toString();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      margin:  const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      decoration: CardDecoration(16),
      child: Column(
        children: [
           Header3Text(widget.sensorType,textStyle: TextStyle(color: widget.color,fontWeight: FontWeight.bold),), ListTile(leading: widget.leading,
            trailing: !widget.data.isEmpty?Header5Text(_getCurrentDate()):Header5Text("______________"),textColor: Colors.black45,),
          ListTile(leading: !widget.data.isEmpty?Header2Text("${_getCurrentValue()}${Sensor.getSensorUnit(widget.sensorType)}",textStyle: TextStyle(fontWeight: FontWeight.bold),):
          Header5Text("no data", textStyle: TextStyle(color:Colors.black45 ),),
            trailing:Icon(Icons.arrow_forward_ios),
          onTap: (){
           RouterManager.gotoPlantDataPage(context, widget.data, widget.sensorType);
          },)

        ],
      ),

    );
  }
}
