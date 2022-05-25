


import 'package:flutter/material.dart';
import 'package:plantbuddy/model/Configuration/Configuration.dart';
import 'package:plantbuddy/model/Sensor.dart';
import 'package:plantbuddy/model/User.dart';
import '../../model/Plant.dart';
import '../Decoration/CardDecoration.dart';
import '../Loading.dart';
import '../text.dart';


//ignore: must_be_immutable
class SingleSliderCard extends StatefulWidget {
  final Plant plant;
  final Widget leadingIcon;
  final String text;
  double max;
  double value;
   SingleSliderCard({Key? key, required this.plant, required this.max, required this.text , required this.leadingIcon, required this.value}) : super(key: key);

  @override
  _SingleSliderCardState createState() => _SingleSliderCardState();
}

class _SingleSliderCardState extends State<SingleSliderCard> {


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
            Expanded(flex: 5,child:  Slider(
                activeColor: Sensor.getSensorColor(widget.text),
                min: 0,
                max: widget.max,
                value: widget.value,
                onChanged: (newValue){
                  setState(() {
                    widget.value=newValue;
                  });
                }),),
          ],),
           Header3Text('value: ${widget.value.toInt()}${Sensor.getSensorUnit(widget.text)}',
            textStyle: TextStyle(color: Sensor.getSensorColor(widget.text))),
          SizedBox(height: 8,),
        ],
      ): Loading(),

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
            await User().UserUpdate_Configuration(widget.plant.PlantID, Configuration.getConfigurationID(widget.text), widget.value.toInt().toDouble(), null);
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
