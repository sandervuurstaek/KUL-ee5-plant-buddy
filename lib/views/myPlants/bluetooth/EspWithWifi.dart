import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/TextForm.dart';
import 'package:plantbuddy/widgets/Toast.dart';
import '../../../widgets/specialButton.dart';
import '../../../widgets/text.dart';
import '../../../widgets/transparant_appbar.dart';


class EspWithWifi extends StatefulWidget {
  BluetoothDevice device;
  String api_key;
  List<BluetoothService> service;
  EspWithWifi({Key? key,required this.device,required this.api_key,required this.service}) : super(key: key);

  @override
  _EspWithWifiState createState() => _EspWithWifiState();
}

class _EspWithWifiState extends State<EspWithWifi> {
  String? SSID='';
  String? BSSID='';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PasswordTextForm passwordTextForm = PasswordTextForm(text: 'Wifi Password');


  @override
  void initState() {
    super.initState();
  }
  Future<String?> getSSID() async {
    PermissionWithService locationPermission = Permission.locationWhenInUse;
    var permissionStatus = await locationPermission.status;
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationPermission.request();

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await locationPermission.request();
      }
    }
    // Removed piece of code here, since the variable mentioned in it was not included
    if (permissionStatus == PermissionStatus.granted) {
      bool isLocationServiceOn = await locationPermission.serviceStatus.isEnabled;
      if (isLocationServiceOn){
        final info = NetworkInfo();
        SSID = await info.getWifiName();
        print('The wifi name is: $SSID');
      } else {
        print('Location Service is not enabled');
      }
    }
      return SSID;
  }

  Future<String?> getBSSID()async{
    PermissionWithService locationPermission = Permission.locationWhenInUse;
    var permissionStatus = await locationPermission.status;
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locationPermission.request();

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await locationPermission.request();
      }
    }
    // Removed piece of code here, since the variable mentioned in it was not included
    if (permissionStatus == PermissionStatus.granted) {
      bool isLocationServiceOn = await locationPermission.serviceStatus.isEnabled;
      if (isLocationServiceOn){
        final info = NetworkInfo();
        BSSID = await info.getWifiBSSID();
        print('The wifi name is: $SSID');
      } else {
        print('Location Service is not enabled');
      }
    }
    return BSSID;
  }



  @override
  Widget build(BuildContext context) {
    Widget wifiInfo=Container(
      margin: EdgeInsets.all(8),
      decoration: CardDecoration(16),
      child: Column(
        children: [
          FutureBuilder(
            future: getSSID(),
            builder:(c, snapshot){
                  return ListTile(
                    title: snapshot.hasData?Header3Text(snapshot.data):Header3Text(''),
                    leading: Header3Text("SSID"),
                    trailing: Icon(Icons.wifi,color: Colors.blue,),
                  );
              }
          ),
          FutureBuilder(
              future: getBSSID(),
              builder:(c, snapshot){
                return ListTile(
                  title: snapshot.hasData?Header3Text(snapshot.data):Header3Text(''),
                  leading: Header3Text("BSSID"),
                );
              }
          ),
        ],
      ),
    );
    Widget passwordarea=Container(
      margin:  const EdgeInsets.only(left: 20,right: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            const SizedBox(height: 10),
             passwordTextForm,
            const SizedBox(height: 32),
          ],
        ),
      ),
    );

    Widget sendButtonArea=Container(
        margin:  const EdgeInsets.only(left: 20,right: 20),
        child: RoundedButton(data: "Connect", pressed: send_wifiInfo_to_Esp));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TransparantAppbar(
        title: 'Esp-Wifi Connection ',
      ),
      body: Center(
        child: Column(
            children:[
              SizedBox(height: 30,),
              wifiInfo,
              SizedBox(height: 30,),
              passwordarea,
              SizedBox(height: 30,),
              sendButtonArea
            ]
        ),
      ),

    );;
  }

  void send_wifiInfo_to_Esp() async {
    if(SSID!=null && SSID!='')
      {
        runZonedGuarded(
                ()async{
              int counter=0;
              widget.service.forEach((service) async {
                print('0x${service.uuid.toString().toUpperCase().substring(4, 8)}');
                if('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'=="0x00FF")
                {
                  counter = await _writeToCharacteristic(service, counter);
                  if(counter==3){
                    _successToWrite();
                  }
                }
              });

            },wirte_exception_handler
        );
      }
    else{
      ToastDialog.show_toast("Failed to get SSID");
    }
   
      }

  void _successToWrite() {
    widget.device.disconnect();
    // User().updatedInfo=true;
    go_back_to_Homepage();
  }

  Future<int> _writeToCharacteristic(BluetoothService service, int counter) async {
    service.characteristics.forEach((characteristic) async {
      String uuid='0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}';
      print(uuid);
      if(uuid=='0xFF02')//SSID
          {
        print("write to ssid");
        await characteristic.write(Uint8List.fromList(SSID!.codeUnits));
        counter++;
      }
      else if(uuid=='0xFF03')//PASSWORD
          {
        print(passwordTextForm.passwordEditingController.text);
        print("write password");
        await characteristic.write(Uint8List.fromList(passwordTextForm.passwordEditingController.text.codeUnits));
        counter++;
      }
      else if(uuid=='0xFF04')//API_KEY
          {
        print("write api key");
        print(widget.api_key);
        await characteristic.write(Uint8List.fromList(widget.api_key.codeUnits));
        counter++;
      }
    });
    return counter;
  }

  void go_back_to_Homepage() {
     RouterManager.toHomepage(context);
  }

  void wirte_exception_handler(dynamic e, StackTrace stack){
    ToastDialog.show_toast("Unable to connect with ");
  }
  
}
