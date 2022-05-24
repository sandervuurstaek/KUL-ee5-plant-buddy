import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/model/Sensor.dart';
import 'package:plantbuddy/widgets/ClipperPath.dart';
import 'package:plantbuddy/widgets/LoadingDialog.dart';
import 'package:plantbuddy/widgets/TextForm.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../controller/BlueToothController.dart';
import '../../model/Data.dart';
import '../../model/Photo.dart';
import '../../model/Plant.dart';
import '../../model/User.dart';
import '../../widgets/Card/ListTileCard.dart';
import '../../widgets/Card/SensorCard.dart';
import '../../widgets/Toast.dart';
import '../../widgets/specialButton.dart';
import '../../widgets/transparant_appbar.dart';


//ignore: must_be_immutable
class PlantInfoPage extends StatefulWidget {
  Plant plant;
  PlantInfoPage({required this.plant,Key? key}) : super(key: key);

  @override
  _PlantInfoPageState createState() => _PlantInfoPageState();
}

class _PlantInfoPageState extends State<PlantInfoPage> {
  TextForm nameForm= TextForm(text: 'New Name',);
  var image=null;
  bool loading=false;
  var firstname=User().firstname;
  var lastname=User().lastname;

  late Widget headimage= widget.plant.pict==null?Image.asset("asset/defaultPlantPhoto.jpg",fit: BoxFit.fitWidth,
    width: double.infinity,
    height: 350,
    color: Color.fromRGBO(76, 73, 73, 0.4),
    colorBlendMode: BlendMode.difference,
    filterQuality: FilterQuality.high,
  ): Image.memory(widget.plant.pict!,fit: BoxFit.cover,
    width: double.infinity,
    height: 350,
    color: Color.fromRGBO(76, 73, 73, 0.4),
    colorBlendMode: BlendMode.difference,
    filterQuality: FilterQuality.high,);

  
  _tryDelete() async {
   _enterLoading();
    var code= await User().User_delete_device(widget.plant.PlantID);
    if(code==200)
    {
      RouterManager.toHomepage(context);
    }
    else{
   _leaveLoading();
    }
  }
  
  @override
  void initState() {
    super.initState();
  }

  void _pressCamera()async{
    Photo photo = await _getPhoto(context);
    if(photo.imagepath!=null)
    {
      _chanegImagePath(photo);
      String img64= base64Encode(photo.imagepath.readAsBytesSync());
      await _uploadNewPhoto(img64);
      _leaveLoading();
    }
  }
 void _pressSetting(){
   RouterManager.toConfigureationPage(context, widget.plant);
 }



  Future _refresh() async {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget camera = IconButton(onPressed: _pressCamera,
      icon: Icon(Icons.camera_alt_rounded),
      color: Colors.white,
      iconSize: 48,);

    Widget setting = IconButton(onPressed: _pressSetting,
      icon: Icon(Icons.settings),
    color: Colors.white,
    iconSize: 48,);


    Widget bluetoothConfigure= IconButton(onPressed: () => BlueToothController.configureDeviceWifi(context,widget.plant), icon: Icon(Icons.bluetooth_audio_rounded,),color: Colors.white,
      iconSize: 48,);


    //plant_Info page head widget
    Widget PlantInfoHead=  Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          child: image==null?Image.asset("asset/defaultPlantPhoto.jpg",fit: BoxFit.fitWidth,
            width: double.infinity,
            height: 350,
            color: Color.fromRGBO(76, 73, 73, 0.4),
            colorBlendMode: BlendMode.difference,
            filterQuality: FilterQuality.high,
          ): Image.file(image!,fit: BoxFit.cover,
            width: double.infinity,
            height: 350,
            color: Color.fromRGBO(76, 73, 73, 0.4),
            colorBlendMode: BlendMode.difference,
            filterQuality: FilterQuality.high,),
          clipper: ClipperPath(),
        ),
        Positioned(
          bottom: 32,
          child: Column(
            children: [
              !kIsWeb ?Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  setting,
                  SizedBox(width: 200,),
                  bluetoothConfigure
                ],):setting,
              SizedBox(height: 100,),
              Header1Text("$firstname $lastname",textStyle: TextStyle(color: Colors.white,),),
              Row(
                children: [
                  Header2Text(widget.plant.PlantName, textStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
                  IconButton(
                      onPressed: (){
                        _changeName(context);
                        }
                      , icon: Icon(Icons.edit_rounded,color: Colors.white,)),
                ],
              ),
              !kIsWeb ?camera:Container(),
            ],
          ),
        ),
      ],
    );

    //when no plants data
    Widget noDataWidget= ListTileCard(leading:Icon(Icons.hourglass_empty_rounded,color: Colors.blue,size: 48,),text:"No Data Found");


    //when failed to fetch plants data
    Widget errorWidget= ListTileCard(leading:Icon(Icons.error_outline_rounded,color: Colors.red,size: 48,),text:"Failed To Fetch Data");


   Widget DataArea = FutureBuilder<dynamic>(
      future: User().User_get_measurement(widget.plant.PlantID),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData)
            {
              return _getDataArea(snapshot);

            }
            else if(snapshot.hasError)
            {
              print(snapshot.error);
              print(snapshot.stackTrace);
              ToastDialog.show_toast(snapshot.error.toString());
              return errorWidget;
            }
            else{
              return noDataWidget;

            }
          }
          else{
            return Center(child: LoadingDialog());
          }
        }
    );
    


    return Scaffold(
     appBar: const TransparantAppbar(
        title: '',
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 710),
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: !loading?Scrollbar(
              child:  ListView(
                                  children: [
                                    PlantInfoHead,
                                    SizedBox(height: 40),
                                    DataArea,
                                    SizedBox(height: 40),
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      child: RoundedButton(data: "Delete Plant", pressed: _tryDelete,),
                                    ),
                                    SizedBox(height: 80,)
                                  ],
                                ),

            ):LoadingDialog(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
          onPressed: _refresh,
          child: const Icon(Icons.refresh)) ,
    );
  }

  Column _getDataArea(AsyncSnapshot<dynamic> snapshot) {
     List<Data> plantData=[];
    _getDataForPlant(snapshot, plantData);

    return Column(
      children: [
        _getDataCard(plantData,"Temperature"),
        _getDataCard(plantData,"Pressure"),
        _getDataCard(plantData,"IAQ"),
        _getDataCard(plantData,"LDR"),
        _getDataCard(plantData,"Water_Level"),
        _getDataCard(plantData,"Moisture"),
        _getDataCard(plantData,"Humidity"),
      ],
    );
  }

  
  Widget _getDataCard(List<Data> plantData, String type)
  {
    Color color =Sensor.getSensorColor(type);
    Widget icon=Sensor.getSensorIcon(type, 36);
    List<Data> data=plantData.where((element) => element.type==type).toList();
    Widget Card=SensorCard(leading: icon,
      sensorType: type, color: color,
      data: data,);
    return Card;
  }


  void _getDataForPlant(AsyncSnapshot<dynamic> snapshot, List<Data> plantData) {
     for(int i=0;i<snapshot.data.length;i++ )
      {
        Data data=Data(timeStamp: snapshot.data[i]["timestamp"],
            value: snapshot.data[i]["data"].toDouble(),
            type: Sensor.getSensorType(snapshot.data[i]["sensor_id"]));
        plantData.add(data);
      }
  }

  void _changeName(BuildContext context) {
    showDialog(
      context: context,
    builder: (context)=>AlertDialog(title: Header3Text("New Name"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: nameForm,
    actions: [
      TextButton(child: Header3Text('CANCEL',textStyle: TextStyle(color: Colors.blueAccent),), onPressed: ()  {
        Navigator.pop(context);
      }),
      TextButton(child: Header3Text('OK',textStyle: TextStyle(color: Colors.blueAccent)), onPressed: () async {
        String newName=nameForm.textEditingController.text;
        if(newName!=''){
        _enterLoading();
          await User().UserUpdate_device(widget.plant.PlantID, '' ,newName );
          setState(() {
            loading=false;
            widget.plant.PlantName=newName;
          });
        }
        Navigator.pop(context);
      })
    ],),);
  }

  Future<Photo> _getPhoto(BuildContext context) async {
     Photo photo=Photo();
    await photo.changePhoto(context);
    return photo;
  }

  Future<void> _uploadNewPhoto(String img64) async {
     runZonedGuarded(() async {
      int code= await User().UserUpdate_device(widget.plant.PlantID, img64, widget.plant.PlantName);
      if(code==200)
      {
        _leaveLoading();
      }
    }, _changePhotoExceptionHandler);
  }

  void _changePhotoExceptionHandler(dynamic e, StackTrace stack){
    ToastDialog.show_toast("Time out, Please try again");
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

  void _chanegImagePath(Photo photo) {
     setState(() {
      loading=true;
      image=photo.imagepath;
    });
  }
}


