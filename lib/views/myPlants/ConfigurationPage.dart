import 'package:flutter/material.dart';
import 'package:plantbuddy/model/Configuration/RangeValueConfiguration.dart';
import 'package:plantbuddy/model/Configuration/SingleValueConfiguration.dart';
import 'package:plantbuddy/model/Sensor.dart';
import 'package:plantbuddy/model/User.dart';
import 'package:plantbuddy/widgets/Card/SingleSliderCard.dart';
import 'package:plantbuddy/widgets/Card/SliderCard.dart';

import '../../model/Plant.dart';
import '../../widgets/Card/ListTileCard.dart';
import '../../widgets/Loading.dart';
import '../../widgets/LoadingDialog.dart';
import '../../widgets/Toast.dart';
import '../../widgets/transparant_appbar.dart';
//ignore: must_be_immutable
class ConfigurationPage extends StatefulWidget {
   Plant plant;
  ConfigurationPage({Key? key,required this.plant}) : super(key: key);

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  bool loading=false;
  double size=24;


  @override
  Widget build(BuildContext context) {

//when no plants found
    Widget nodataWidget= ListTileCard(leading:Icon(Icons.hourglass_empty_rounded,color: Colors.blue,size: 48,),text:"No Configuration Found");


    //when failed to fetch plants
    Widget errorWidget= ListTileCard(leading:Icon(Icons.error_outline_rounded,color: Colors.red,size: 48,),text:"Failed To Fetch Configuration");

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
                image,
                SizedBox(height: 20,),

                FutureBuilder(
                  future: User().UserGet_Configuration(widget.plant.PlantID),
                  builder: (c, snapshot){
                    if(snapshot.connectionState==ConnectionState.done)
                    {
                      if(snapshot.hasData)
                      {
                        List<SingleValueConfiguration> configurations=SingleValueConfiguration.getConfigurations(snapshot.data);
                        List<RangeValueConfiguration> rangeConfigurations=RangeValueConfiguration.getConfigurations(snapshot.data);
                       return _buildConfiguration(configurations, rangeConfigurations);

                      }
                      else if(snapshot.hasError)
                      {
                        print(snapshot.error);
                        print(snapshot.stackTrace);
                        ToastDialog.show_toast(snapshot.error.toString());
                        return errorWidget;
                      }
                      else{
                        return  nodataWidget;
                      }
                    }
                    else{
                      return Center(child: Loading());
                    }
                  },
                ),

              ],
            ),
          ):LoadingDialog(),
        ),
      ),
    );
  }

  Widget _buildConfiguration(List<SingleValueConfiguration> singleValueConfigurations, List<RangeValueConfiguration> rangeValueConfiguration){

    Widget LDRBar=_getSliderCard(rangeValueConfiguration, "LDR");
    Widget moistureBar=_getSliderCard(rangeValueConfiguration, "Moisture");

    Widget LED_white=_getSingleSliderCard(singleValueConfigurations, "LED_white");
    Widget LED_blue=_getSingleSliderCard(singleValueConfigurations, "LED_blue");
    Widget LED_hyper_red=_getSingleSliderCard(singleValueConfigurations, "LED_hyper_red");
    Widget LED_far_red=_getSingleSliderCard(singleValueConfigurations, "LED_far_red");
    
    return Column(
      children: [
        SizedBox(height: 20,),
        LDRBar,
        SizedBox(height: 20,),
        moistureBar,
        SizedBox(height: 20,),
        LED_white,
        SizedBox(height: 20,),
        LED_blue,
        SizedBox(height: 20,),
        LED_hyper_red,
        SizedBox(height: 20,),
        LED_far_red,
        SizedBox(height: 20,),
      ],
    );
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

  Widget _getSingleSliderCard(List<SingleValueConfiguration> singleValueConfigurations, String type){
    SingleSliderCard singleSliderCard;
    if(singleValueConfigurations.where((element) => element.type==type).isNotEmpty)
    {
      SingleValueConfiguration configurations=singleValueConfigurations.where((element) => element.type==type).toList()[0];
      singleSliderCard=SingleSliderCard(plant: widget.plant, max: 100, text: type,
          leadingIcon: Sensor.getSensorIcon(type,36), value: configurations.min);
      return singleSliderCard;
    }
    else{
      return SizedBox(height: 10,);
    }
  }
  
  
  Widget _getSliderCard(List<RangeValueConfiguration> rangeValueConfigurations, String type)
  {
    SliderCard sliderCard;
    if(rangeValueConfigurations.where((element) => element.type==type).isNotEmpty)
    {
      RangeValueConfiguration configurations=rangeValueConfigurations.where((element) => element.type==type).toList()[0];
      sliderCard=SliderCard(plant: widget.plant, max: 100, text: type,
          leadingIcon: Sensor.getSensorIcon(type,36), selectRange: RangeValues(configurations.min,configurations.max), min: 0,);
      return sliderCard;
    }
    else{
      return SizedBox(height: 10,);
    }
  }
}
