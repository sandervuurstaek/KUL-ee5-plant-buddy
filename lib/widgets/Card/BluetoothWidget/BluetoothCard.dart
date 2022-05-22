

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/Loading.dart';
import 'package:plantbuddy/widgets/Toast.dart';
import 'package:plantbuddy/widgets/text.dart';


class BluetoothCard extends StatefulWidget {
  final ScanResult result;
  const BluetoothCard({Key? key, required this.result}) : super(key: key);

  @override
  _BluetoothCardState createState() => _BluetoothCardState();
}

class _BluetoothCardState extends State<BluetoothCard> {
  bool connecting=false;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(8),
      decoration: CardDecoration(16),
      child: ListTile(
        title: Header3Text(widget.result.device.name),
        subtitle: Header3Text(widget.result.device.id.toString()),
        leading: Icon(Icons.bluetooth,color: Colors.blue,),
        trailing: connecting?Loading():Icon(Icons.arrow_forward_ios),
        onTap: connect_with_device,

      ),
    );
  }

  void connect_with_device() async {
        runZonedGuarded(() async {
          enter_loading();
          await widget.result.device.connect(timeout: Duration(seconds: 6));
          leave_loading();
        },connection_exception_handler);
      }

  void connection_exception_handler(dynamic e, StackTrace stack){
    ToastDialog.show_toast("Unable to connect with this device");
  }

  void leave_loading() {
     setState(() {
      connecting=false;
    });
  }

  void enter_loading() {
     setState(() {
      connecting=true;
    });
  }
}


