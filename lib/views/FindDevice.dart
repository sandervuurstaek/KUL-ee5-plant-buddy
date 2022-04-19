import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/widgets/BluetoothCard.dart';
import '../widgets/transparant_appbar.dart';

class BlueToothSearch extends StatelessWidget {
  const BlueToothSearch(BuildContext context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparantAppbar(
        title: 'Find Devices',
      ),
      body:
          StreamBuilder(
              stream: FlutterBlue.instance.state,
              initialData: BluetoothState.unknown,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state == BluetoothState.on) {
                  return FindDevicesPage();
                }
                return BluetoothOffScreen();
              }
    ),

      );


  }
}

class FindDevicesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
    return RefreshIndicator(
        onRefresh: ()=> FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: StreamBuilder<List<ScanResult>>(
                      stream: FlutterBlue.instance.scanResults,
                      initialData: [],
                      builder: (c, snapshot){
                        if(snapshot.hasError)
                          {
                            return CircularProgressIndicator();
                          }
                        return ListView(
                        children: /*[BluetoothCard(),
                          BluetoothCard(),
                          BluetoothCard(),]*/
                            snapshot.data!
                            .map(
                              (r) => BluetoothCard(
                                result: r,
                              ),
                        )
                            .toList(),
                      );}
                    ),
        );
  }

}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.grey,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
            ),
          ],
        ),
      );
  }
}


