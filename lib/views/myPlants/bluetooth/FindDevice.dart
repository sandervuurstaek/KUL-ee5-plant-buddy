import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/widgets/Card/BluetoothWidget/ConnectedBluetoothCard.dart';
import 'package:plantbuddy/widgets/text.dart';
import '../../../widgets/Card/BluetoothWidget/BluetoothCard.dart';
import '../../../widgets/Card/ListTileCard.dart';
import '../../../widgets/transparant_appbar.dart';

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
                  return SelectDevices();
                }
                return BluetoothOffScreen();
              }
    ),

      );


  }
}

class SelectDevices extends StatefulWidget {
  const SelectDevices({Key? key}) : super(key: key);

  @override
  _SelectDevicesState createState() => _SelectDevicesState();
}

class _SelectDevicesState extends State<SelectDevices> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {


    Widget nodeviceWidget= ListTileCard(leading:Icon(Icons.bluetooth_connected_rounded,color: Colors.blue,size: 48,),text:"No device Found");

    Widget noConnectedDeviceWidget= ListTileCard(leading:Icon(Icons.bluetooth_connected_rounded,color: Colors.blue,size: 48,),text:"No connected device");

    Widget errorWidget= ListTileCard(leading:Icon(Icons.error,color: Colors.red,size: 48,),text:"Error");

    Widget connectedDevice=Container(margin: EdgeInsets.all(8),child: Header5Text("Connected Devices",textStyle: TextStyle(color: Colors.grey),));

    Widget availableDevice=Container(margin: EdgeInsets.all(8),child: Header5Text("Avalible Devices",textStyle: TextStyle(color: Colors.grey)));


    return Container(
      child: RefreshIndicator(
        onRefresh: ()=> flutterBlue.startScan(timeout: Duration(seconds: 4)),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                connectedDevice,
                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.periodic(Duration(seconds: 2)).asyncMap((_) => FlutterBlue.instance.connectedDevices),
                    initialData: [],
                    builder: (c,snapshot){
                    if(snapshot.data!.isEmpty)
                      {
                        return noConnectedDeviceWidget;
                      }
                    else{
                      return Column(
                        children: snapshot.data!.map((e) => ConnectedBluetoothCard(device: e)).toList(),
                      );
                    }
                    }
                ),
               availableDevice,
                StreamBuilder<List<ScanResult>>(
                    stream: FlutterBlue.instance.scanResults,
                    initialData: [],
                    builder: (c, snapshot){
                      if(snapshot.connectionState==ConnectionState.active
                      || snapshot.connectionState==ConnectionState.done)
                        {
                          if(snapshot.hasError)
                            {
                              return errorWidget;
                            }
                          else if(snapshot.hasData)
                            {//.where((result) => result.device.name=="PlantBuddy")
                              if(snapshot.data!.isEmpty)
                              {
                                return nodeviceWidget;
                              }
                              else
                                {
                                  if(snapshot.data!.where((element) => element.device.name!='').isEmpty)
                                    {
                                      return nodeviceWidget;
                                    }
                                  else{
                                    return  Column(
                                      children: snapshot.data!.where((element) => element.device.name!='').map((result) => BluetoothCard(result: result)).toList(),
                                    );
                                  }
                                }
                            }
                          else{
                            return nodeviceWidget;
                          }
                        }
                      else{
                        return CircularProgressIndicator();
                      }
                 }
                ),
              ],
            ),
          ),
        ),
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
              color: Colors.blue,
            ),
            Header5Text('Bluetooth Adapter is not available',textStyle: TextStyle(color: Colors.grey))
          ],
        ),
      );
  }
}


