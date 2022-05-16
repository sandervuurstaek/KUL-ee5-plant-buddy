import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';

import 'CharacteristicCard.dart';

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key? key, required this.service, required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return  ExpansionTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Service'),
              Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',),
              //Text('0x${service.toString().toUpperCase().substring(4, 8)}',)
            ],
          ),
          children: characteristicTiles,
        );
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle:
        Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}