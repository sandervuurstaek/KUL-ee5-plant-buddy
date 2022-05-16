import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/Card/SliderCard.dart';

import '../../model/Plant.dart';
import '../../widgets/LoadingDialog.dart';
import '../../widgets/specialButton.dart';
import '../../widgets/transparant_appbar.dart';

class ConfigurationPage extends StatefulWidget {
  Plant plant;
  ConfigurationPage({Key? key,required this.plant}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool loading=false;

  SliderCard temperatureBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.cloud_circle, color: Colors.blue,size: 48,),text: "Temperature",);
  SliderCard pressureBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.sensors_rounded, color: Colors.redAccent,size: 48,),text: "Pressure",);
  SliderCard IAQBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.air_rounded, color: Colors.blue,size: 48,),text: "IAQ",);
  SliderCard LDRBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.social_distance_rounded, color: Colors.green,size: 48,),text: "LDR",);
  SliderCard water_levelBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.water_drop_sharp, color: Colors.blueAccent,size: 48,),text: "Water Level",);
  SliderCard moistureBar=SliderCard(min: 0,max: 100,leadingIcon: Icon(Icons.water_outlined,color: Colors.grey,size: 48,),text: "Moisture", );
  SliderCard humidityBar=SliderCard(min: 0, max: 100, leadingIcon: Icon(Icons.water,color: Colors.amberAccent,size: 48,), text: "Humidity");

  @override
  Widget build(BuildContext context) {
    Widget image=Container(
        margin:  const EdgeInsets.only(left: 16,right: 16),
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('asset/configurePlant.jpg'),
              fit: BoxFit.fill,
              ),
        )
    );

    Widget button=Container(
      margin: EdgeInsets.all(16),
      child: RoundedButton(data: "Save Change", pressed: _pressSave,),
    );



    return Scaffold(
      appBar: const TransparantAppbar(
        title: 'Configuration',
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 710),
          child: !loading?Scrollbar(
            child: ListView(
              children: [
                SizedBox(height: 20,),
                image,
                SizedBox(height: 20,),
                temperatureBar,
                SizedBox(height: 20,),
                pressureBar,
                SizedBox(height: 20,),
                IAQBar,
                SizedBox(height: 20,),
                LDRBar,
                SizedBox(height: 20,),
                water_levelBar,
                SizedBox(height: 20,),
                moistureBar,
                SizedBox(height: 20,),
                humidityBar,
                SizedBox(height: 20,),
                button,



              ],
            ),
          ):LoadingDialog(),
        ),
      ),
    );;
  }

  void _pressSave(){
    _enterLoading();
    temperatureBar.selectRange.start;
    temperatureBar.selectRange.end;
  _leaveLoading();
    }

  void _leaveLoading() {
    setState(() {
      loading=false;
    });
  }

  void _enterLoading() {
     setState(() {
      loading=true;
    });
  }
}
