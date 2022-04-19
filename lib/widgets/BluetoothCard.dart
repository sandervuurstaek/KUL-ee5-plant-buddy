

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/widgets/text.dart';

class BluetoothCard extends StatelessWidget {

  final ScanResult? result;
  final VoidCallback? onTap;
  
  const BluetoothCard({Key? key, this.result,this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0.25,
            blurRadius: 20,
            // offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: ListTile(
        title: Header3Text("111111"),
        subtitle: Header3Text("1111111"),
        leading: Icon(Icons.bluetooth),
        trailing: Icon(Icons.settings),
        onTap: onTap,

 ),
    );
  }
}
