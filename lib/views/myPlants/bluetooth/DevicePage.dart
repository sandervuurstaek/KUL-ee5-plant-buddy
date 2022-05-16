
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/model/user.dart';
import 'package:plantbuddy/widgets/Loading.dart';


import 'package:plantbuddy/widgets/Card/BluetoothWidget/DescriptorCard.dart';
import 'package:plantbuddy/widgets/Card/BluetoothWidget/ServiceCard.dart';
import '../../../widgets/Card/BluetoothWidget/CharacteristicCard.dart';
import '../../../widgets/transparant_appbar.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  List<Widget> _buildServiceTiles(List<BluetoothService>? services) {
    if(services==null)
      {
        return [];
      }
    else{
      return services
          .map(
            (s) => ServiceTile(
          service: s,
          characteristicTiles: s.characteristics
              .map(
                (c) => CharacteristicTile(
              characteristic: c,
              onReadPressed: () => c.read(),
              onWritePressed: () async {
                await c.write([0x12, 0x34]); //0x12
              },
              onNotificationPressed: () async {
                await c.setNotifyValue(!c.isNotifying);
                await c.read();
              },
                  descriptorTiles: c.descriptors
                      .map(
                        (d) => DescriptorTile(
                      descriptor: d,
                      onReadPressed: () => d.read(),
                    ),
                  )
                      .toList(),
            ),
          )
              .toList(),
        ),
      )
          .toList();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparantAppbar(
        title: '',
      ),
      body: FutureBuilder<List<BluetoothService>>(
        future: device.discoverServices(),
        builder: (c, snapshot){
          if(snapshot.connectionState==ConnectionState.active
              || snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData)
            {
              return Scrollbar(
                child: ListView(
                  children: _buildServiceTiles(snapshot.data),
                ),
              );
            }
            else{
              return Loading();
            }
          }
          else{
            return Loading();
          }
        },
      ),
    );
  }
}