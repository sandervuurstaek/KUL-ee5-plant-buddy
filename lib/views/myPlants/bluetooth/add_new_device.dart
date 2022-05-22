import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../../../controller/RouterManager.dart';
import '../../../model/User.dart';
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


    Widget pictureArea=  Container(
      margin:  const EdgeInsets.only(left: 20,right: 20),
      width: 100,
      height: 200,
      child:IconButton(onPressed:(){

      },
        icon: Icon(Icons.camera_alt_rounded),
        color: Colors.grey,
        iconSize: 48,),
    decoration: CardDecoration(16),);


    Widget inputTextArea =Container(
      margin:  const EdgeInsets.only(left: 20,right: 20),
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
        await get_new_plant(context);
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
            SizedBox(height: 20,),
            inputTextArea,
            SizedBox(height: 20,),
            submitButtonArea,
          ]
      ),

    );
  }

  Future<void> get_new_plant(BuildContext context) async {
     runZonedGuarded(
        () async{
          List json= await User().UserAdd_new_device(plantnameForm.textEditingController.text, widget.device.id.toString());
          if(json.isNotEmpty)
            {
              var api_key=json[0]["api_key"];
              var id=json[0]["id"];
              get_bluetooth_service(id,api_key, context);
            }
        },get_api_key_exception_handler
    );
  }

  void get_api_key_exception_handler(dynamic e, StackTrace stack){
    print(stack);
    print(e);
    ToastDialog.show_toast(e.toString());
      }

  Future<void> get_bluetooth_service(int id, api_key, BuildContext context) async {
     if(api_key!=null)
    {
      List<BluetoothService> services= await widget.device.discoverServices();
      if(services.isNotEmpty)
        {
          connect_esp_to_wifi(context,id, api_key, services);
        }
      else{
        get_no_service_response();
      }
    }
  }

  void get_no_service_response() {
    ToastDialog.show_toast("Device bluetooth no services ");
  }

  void connect_esp_to_wifi(BuildContext context,int id, api_key, List<BluetoothService> services) {
    RouterManager.gotoEspWithWifi(context, id, widget.device, api_key, services, true);
  }
}
