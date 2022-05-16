import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import '../../../views/myPlants/bluetooth/add_new_device.dart';
import '../../Toast.dart';
import '../../text.dart';

class ConnectedBluetoothCard extends StatefulWidget {
  final BluetoothDevice device;
  const ConnectedBluetoothCard({Key? key, required this.device}) : super(key: key);


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
          add_new_device(context);
        },
      ),
    );
  }

  void add_new_device(BuildContext context) {
    runZonedGuarded(() async {
      RouterManager.gotoAddNewDevicePage(context, widget.device);
    },add_new_device_exception_handler);
  }

  void add_new_device_exception_handler(dynamic e, StackTrace stack){

    ToastDialog.show_toast("Unable to connect with this device");
  }
}
