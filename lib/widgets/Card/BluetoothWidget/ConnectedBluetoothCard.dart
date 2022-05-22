import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../../../model/Plant.dart';
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
            if(widget.plant!=null && widget.plant?.device_identifier.toString()==widget.device.id.toString() )
              {
                await _configureWifi(context);
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
    if(services.isNotEmpty )
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



  void _add_new_device_exception_handler(dynamic e, StackTrace stack){
    ToastDialog.show_toast("Unable to connect with this device");
  }

}
