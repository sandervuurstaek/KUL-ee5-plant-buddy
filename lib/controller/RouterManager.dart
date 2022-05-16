
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:plantbuddy/views/myPlants/ConfigurationPage.dart';

import '../model/Plant.dart';
import '../views/home/home.dart';
import '../views/myPlants/bluetooth/FindDevice.dart';
import '../views/myPlants/bluetooth/add_new_device.dart';
import '../views/setting/accountPage.dart';
import '../views/startpage/startpage.dart';

class RouterManager{

   static toHomepage(BuildContext context){
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
         builder: (context) {
           return const Home();
         }), (route) => false);
   }

   static toFrontPage(BuildContext context){
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
         builder: (context) {
           return Frontpage();
         }), (route) => false);
   }

   static toConfigureationPage(BuildContext context, Plant plant){
     Navigator.push(context, MaterialPageRoute(builder: (context){
       return ConfigurationPage(plant: plant);
     }));
   }

   static goBack(BuildContext context){
     Navigator.of(context).pop();
   }

   static gotoBluetoothSearch(BuildContext context){
     Navigator.push(context, MaterialPageRoute(
         maintainState: false,
         builder: (context) {
           return  BlueToothSearch(context);
         }));
   }

   static gotoAddNewDevicePage(BuildContext context,BluetoothDevice device){
     Navigator.push(context, MaterialPageRoute(
         maintainState: false,
         builder: (context) {
           return Add_new_device_page(device: device);
         }));
   }

   static gotoAccountPage(BuildContext context){
     Navigator.push(context, MaterialPageRoute(builder: (context){
       return const accountPage();
     }));
   }

}