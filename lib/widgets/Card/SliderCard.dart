import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/model/Sensor.dart';
import 'package:plantbuddy/widgets/Loading.dart';
import '../../model/Configuration/Configuration.dart';
import '../../model/Plant.dart';
import '../../model/User.dart';
import '../text.dart';

//ignore: must_be_immutable
class SliderCard extends StatefulWidget {
  final Plant plant;
  final double min;
  final double max;
  final Widget leadingIcon;
  final String text;
  RangeValues selectRange;
  SliderCard({Key? key,required this.min, required this.max,required this.leadingIcon,required this.text, required this.plant, required this.selectRange}) : super(key: key);

  @override
  _SliderCardState createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {

  bool loading=false;

  @override
  Widget build(BuildContext context) {


    return Container(
      margin:  const EdgeInsets.only(left: 16,right: 16),
      decoration: CardDecoration(16),
      child: !loading?Column(
        children: [
          SizedBox(height: 8,),
          Row(
            children: [
              Expanded(child: Center(child: Header3Text(widget.text,textStyle: TextStyle(color: Sensor.getSensorColor(widget.text)),)),flex: 3,),
              Expanded(child: Container(
                margin: EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  style:  ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Header5Text("save",textStyle: TextStyle(color: Colors.white)),onPressed: () async {
                   await _saveConfiguration(context);
                },),
              ),flex: 1,)
            ],
          ),
          Row(children: [
            Expanded(child: widget.leadingIcon,flex: 1,),
            Expanded(flex: 5,child:  RangeSlider(
              activeColor: Sensor.getSensorColor(widget.text),
              min: widget.min,
              max: widget.max,
              divisions: 100,
              values: widget.selectRange,
              onChanged: (RangeValues newRange){
                setState(() {
                  widget.selectRange=newRange;
                });
              },
            ),),

          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Header3Text('min: ${widget.selectRange.start.toInt()}${Sensor.getSensorUnit(widget.text)}',
                textStyle: TextStyle(color: Sensor.getSensorColor(widget.text))),
            Header3Text('max: ${widget.selectRange.end.toInt()}${Sensor.getSensorUnit(widget.text)}',
                textStyle: TextStyle(color: Sensor.getSensorColor(widget.text))),
          ],),

          SizedBox(height: 8,),
        ],
      ):Loading(),

    );
  }




  Future<void> _saveConfiguration(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Icon(Icons.settings,color: Colors.blue,),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Header5Text("Save the new Configuration?"),
        actions: [
          TextButton(child: Header3Text('No',textStyle: TextStyle(color: Colors.blueAccent),), onPressed: ()  {
            Navigator.pop(context);
          }),
          TextButton(child: Header3Text('Yes',textStyle: TextStyle(color: Colors.blueAccent)), onPressed: () async {
            Navigator.pop(context);
            _enterLoading();
            await User().UserUpdate_Configuration(widget.plant.PlantID, Configuration.getConfigurationID(widget.text),
                widget.selectRange.start.toInt().toDouble(), widget.selectRange.end);
            _leaveLoading();
          })
        ],),);
  }

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
}
