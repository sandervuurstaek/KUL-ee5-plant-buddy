import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/ClipperPath.dart';
import 'package:plantbuddy/widgets/LoadingDialog.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../../controller/add_new_plant.dart';
import '../../model/Photo.dart';
import '../../model/Plant.dart';
import '../../model/user.dart';
import '../../widgets/Toast.dart';
import '../../widgets/specialButton.dart';
import '../../widgets/transparant_appbar.dart';

class PlantInfo extends StatefulWidget {
  Plant plant;
  PlantInfo({required this.plant,Key? key}) : super(key: key);

  @override
  _PlantInfoState createState() => _PlantInfoState();
}

class _PlantInfoState extends State<PlantInfo> {
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
    var code= await User().User_delete_device(widget.plant.PlantID);
    if(code==200)
    {
      //User().updatedInfo=true;
      RouterManager.toHomepage(context);
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


    Widget bluetoothConfigure= IconButton(onPressed: () => AddNewPlant.addNewPlant(context), icon: Icon(Icons.bluetooth_audio_rounded,),color: Colors.white,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                setting,
                  SizedBox(width: 200,),
                  bluetoothConfigure
              ],),
              SizedBox(height: 100,),
              Header1Text(firstname!=null&&lastname!=null?"$firstname $lastname":"Plant Buddy",textStyle: TextStyle(color: Colors.white,),),
              Header2Text(widget.plant.PlantName, textStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
              camera,
            ],
          ),
        ),
      ],
    );
    


    return Scaffold(
     appBar: const TransparantAppbar(
        title: '',
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 710),
          child: !loading?Scrollbar(
            child: ListView(
                              children: [
                                PlantInfoHead,
                                /*LineChartCard(),
                                LineChartCard(),
                                LineChartCard(),*/
                                //PlantDataArea(plantID: widget.plant.PlantID),
                               //PlantDataArea(plantID: widget.plant.PlantID),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: RoundedButton(data: "Delete Plant", pressed: _tryDelete,),
                                ),
                                SizedBox(height: 40,)
                              ],
                            ),
          ):LoadingDialog(),
        ),
      ),
    );
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

  void _chanegImagePath(Photo photo) {
     setState(() {
      loading=true;
      image=photo.imagepath;
    });
  }
}


