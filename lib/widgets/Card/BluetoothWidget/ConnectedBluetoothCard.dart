import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../../../model/Plant.dart';
import '../../Loading.dart';
import '../../Toast.dart';
import '../../text.dart';

//ignore: must_be_immutable
class ConnectedBluetoothCard extends StatefulWidget {
  final BluetoothDevice device;
  final bool fromAddNew;
  Plant? plant;
  ConnectedBluetoothCard({Key? key,this.plant, required this.device, required this.fromAddNew}) : super(key: key);


  @override
  _ConnectedBluetoothCardState createState() => _ConnectedBluetoothCardState();
}

class _ConnectedBluetoothCardState extends State<ConnectedBluetoothCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: CardDecoration(16),
      child: ListTile(
        title: Header3Text(widget.device.name),
        subtitle: Header3Text(widget.device.id.toString()),
        leading: Icon(Icons.bluetooth_connected_sharp,color: Colors.blueAccent,),
        trailing: Header4Text("connected",textStyle: TextStyle(color: Colors.grey),),
        onTap: () async {
          if(widget.fromAddNew)
            {
              _add_new_device(context);
            }
          else{
            if(widget.plant!=null && widget.plant?.device_identifier.toString()==widget.device.id.toString())
              {
                 _showWifiConnection(context);
              }
            else{
              ToastDialog.show_toast("The plant don't have this device!");
            }
          }

        },
      ),
    );
  }

  Future<void> _configureWifi(BuildContext context) async {
      List<BluetoothService> services= await widget.device.discoverServices();
    if(services.isNotEmpty)
    {
      RouterManager.gotoEspWithWifi(context, widget.plant!.PlantID, widget.device, widget.plant!.api_key,services, widget.fromAddNew);
    }
    else{
      ToastDialog.show_toast("No Bluetooth service");
    }
  }

  void _add_new_device(BuildContext context) {

    runZonedGuarded(() async {
      RouterManager.gotoAddNewDevicePage(context, widget.device);
    },_add_new_device_exception_handler);
  }


  void _showWifiConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Row(
          children: [
            Icon(Icons.wifi,color: Colors.blue,),
            SizedBox(width: 4,),
            Header5Text("Wifi Connection"),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: _connectionInfo(),
        actions: [
          TextButton(child: Header3Text('Cancel',textStyle: TextStyle(color: Colors.blueAccent),), onPressed: ()  {
            Navigator.pop(context);
          }),
          TextButton(child: Header3Text('Reconnect',textStyle: TextStyle(color: Colors.blueAccent)), onPressed: () async {
            Navigator.pop(context);
            await _configureWifi(context);
          })
        ],),);
  }
  
  Widget _connectionInfo(){
    return Container(
      decoration: CardDecoration(16),
      child: FutureBuilder(
              future: _getConnectionInfo(),
              builder:(c, snapshot){
                if(snapshot.connectionState==ConnectionState.done)
                {
                  if(snapshot.hasData)
                  {
                        return ListTile(
                          title: snapshot.data==1?Header5Text("Connected",textStyle: TextStyle(color: Colors.green),):Header5Text('Connection Failed',textStyle: TextStyle(color: Colors.red)),
                          leading: snapshot.data==1?Icon(Icons.wifi_find,color: Colors.green,):Icon(Icons.sms_failed_rounded,color: Colors.red,),
                        );
                  }
                  else if(snapshot.hasError)
                  {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                    ToastDialog.show_toast(snapshot.error.toString());
                    return ListTile(
                      title: Header3Text("Has Error"),
                      leading: Icon(Icons.question_mark_rounded),
                    );
                  }
                  else{
                    return  Center(child: Loading());
                  }
                }
                else{
                  return Center(child: Loading());
                }
              }
          ),

    );
  }

  Future _getConnectionInfo() async {
    List<BluetoothService> services= await widget.device.discoverServices();
    if(services.isEmpty)
      {
        return 0;
      }
    List<int> value=[];
    for(BluetoothService service in services)
      {
        if('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'=="0x00FF")
          {
            for(BluetoothCharacteristic characteristic in service.characteristics)
              {
                if('0x${characteristic.uuid.toString().toLowerCase().substring(4, 8)}'=='0xff05')
                  {
                    //if(characteristic.properties.read)
                    //{
                    await characteristic.setNotifyValue(true);
                    characteristic.value.listen((v) {
                      print(v);
                      value=v;
                    });
                     // value=await characteristic.read();
                      print(value);
                    //}
                  }
              }
          }
      }
    if(value.isEmpty)
    {
      return 0;
    }
    else{
      if(utf8.decode(value)=='1')
      {
        return 1;
      }
      else
      {
        return 0;
      }
    }
  }




  void _add_new_device_exception_handler(dynamic e, StackTrace stack){
    ToastDialog.show_toast("Unable to connect with this device");
  }

}
