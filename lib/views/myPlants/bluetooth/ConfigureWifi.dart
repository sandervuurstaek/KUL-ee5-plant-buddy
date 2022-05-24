import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../model/Plant.dart';

class ConfigureWifi extends StatefulWidget {
  final BluetoothDevice device;
  final Plant plant;
  const ConfigureWifi({Key? key, required this.plant, required this.device}) : super(key: key);

  @override
  _ConfigureWifiState createState() => _ConfigureWifiState();
}

class _ConfigureWifiState extends State<ConfigureWifi> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
