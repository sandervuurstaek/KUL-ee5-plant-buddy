import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
  final BluetoothDevice device;
  final String api_key;
  final List<BluetoothService> service;
  final int id;
  final bool fromAddNew;
  const EspWithWifi({Key? key,required this.device,required this.api_key,required this.service,required this.id, required this.fromAddNew}) : super(key: key);

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
    Widget passWordArea=Container(
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
        child: RoundedButton(data: "Connect ESP to Wifi", pressed: _send_wifiInfo_to_Esp));

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
              passWordArea,
              SizedBox(height: 30,),
              sendButtonArea
            ]
        ),
      ),

    );
  }

  void _send_wifiInfo_to_Esp() async {
    if(SSID!=null && SSID!='')
      {
        runZonedGuarded(
                ()async{
              widget.service.forEach((service) async {
                print('service 0x${service.uuid.toString().toUpperCase().substring(4, 8)}');
                if('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'=="0x00FF")
                {
                  await _writeToCharacteristic(service);
                }
              });
              _successToWrite();
            },_wirte_exception_handler
        );
      }
    else{
      ToastDialog.show_toast("Failed to get SSID");
    }
   
      }

  void _successToWrite() {
   if(widget.fromAddNew)
     {
       _go_back_to_Homepage();
     }
   else{
     _go_back_to_PlantInfo_Page();
   }
    
  }

   _writeToCharacteristic(BluetoothService service) async {
    service.characteristics.forEach((characteristic) async {
      String uuid='0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}';
      print(uuid);
      if(uuid=='0xFF02')//SSID
          {
        print("write to ssid");
        print("$SSID ${passwordTextForm.passwordEditingController.text} ${widget.api_key}");
         await characteristic.write(utf8.encode("$SSID ${passwordTextForm.passwordEditingController.text} ${widget.api_key} ${widget.id}"));
        ToastDialog.show_toast("Successfully write to ESP");
      }
      /*else if(uuid=='0xFF03')//PASSWORD
          {
        print(passwordTextForm.passwordEditingController.text);
        print("write password");
        await characteristic.write(utf8.encode(passwordTextForm.passwordEditingController.text));
       //counter++;
      }*/
      /*else if(uuid=='0xFF04')//API_KEY
          {
        print("write api key");
        print(widget.api_key);
        await characteristic.write(utf8.encode(widget.api_key));
        //counter++;
      }*/
    });

  }

  void _go_back_to_Homepage() {
     RouterManager.toHomepage(context);
  }
  
  void _go_back_to_PlantInfo_Page(){
    RouterManager.goBack(context);
  }

  void _wirte_exception_handler(dynamic e, StackTrace stack){
    print(e);
    print(stack);
    ToastDialog.show_toast("Unable to connect with ");
  }
  
}
