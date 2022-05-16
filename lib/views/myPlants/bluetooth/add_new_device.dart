import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/views/myPlants/bluetooth/EspWithWifi.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../../../model/user.dart';
import '../../../widgets/TextForm.dart';
import '../../../widgets/Toast.dart';
import '../../../widgets/specialButton.dart';
import '../../../widgets/transparant_appbar.dart';

class Add_new_device_page extends StatefulWidget {
  final BluetoothDevice device;
  const Add_new_device_page({Key? key,required this.device}) : super(key: key);
  @override
  _Add_new_device_pageState createState() => _Add_new_device_pageState();
}

class _Add_new_device_pageState extends State<Add_new_device_page> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextForm plantnameForm= TextForm(text: 'Plant Name',);

  @override
  Widget build(BuildContext context) {
    Widget pictureArea=  CircleAvatar(
      radius: 30,
      child: CameraButton(context),
      backgroundColor: Colors.white,
    );
    Widget inputTextArea =Container(
      margin:  const EdgeInsets.only(left: 20,right: 20),
      decoration: CardDecoration(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            plantnameForm,
            const SizedBox(height: 10,),

          ],
        ),
      ),
    );

    void _trySubmit() async {
      if(_formKey.currentState!.validate())
      {
        await get_api_key(context);
      }
    }

    Widget submitButtonArea =  Container(
        margin:  const EdgeInsets.only(left: 20,right: 20),
        child: RoundedButton(data: "Add", pressed: _trySubmit));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TransparantAppbar(
        title: 'Add New plants',
      ),
      body: ListView(
          children:[
            pictureArea,
            inputTextArea,
            submitButtonArea,
          ]
      ),

    );
  }

  Future<void> get_api_key(BuildContext context) async {
     runZonedGuarded(
        () async{
          var api_key= await User().UserAdd_new_device(plantnameForm.textEditingController.text,widget.device.id.toString());
         // print(api_key);
          get_bluetooth_service(api_key, context);
        },get_api_key_exception_handler
    );
  }

  void get_api_key_exception_handler(dynamic e, StackTrace stack){
    print(stack);
    print(e);
    ToastDialog.show_toast(e.toString());
      }

  Future<void> get_bluetooth_service(api_key, BuildContext context) async {
     if(api_key!=null)
    {
      List<BluetoothService> services= await widget.device.discoverServices();
      if(services.isNotEmpty)
        {
          connect_esp_to_wifi(context, api_key, services);
        }
      else{
        get_no_service_response();
      }
    }
  }

  void get_no_service_response() {
    ToastDialog.show_toast("Device bluetooth no services ");
  }

  void connect_esp_to_wifi(BuildContext context, api_key, List<BluetoothService> services) {
     //User().updatedInfo=true;
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EspWithWifi(device: widget.device, api_key: api_key.toString(),service: services,);
        }));
  }
}
