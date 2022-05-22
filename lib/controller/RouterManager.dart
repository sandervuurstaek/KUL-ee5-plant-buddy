
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:plantbuddy/views/myPlants/ConfigurationPage.dart';
import 'package:plantbuddy/views/myPlants/PlantDataPage.dart';

import '../model/Data.dart';
import '../model/Plant.dart';
import '../views/home/home.dart';
import '../views/myPlants/bluetooth/EspWithWifi.dart';
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

   static gotoBluetoothSearch(BuildContext context, bool fromAddNew, Plant? plant){
     Navigator.push(context, MaterialPageRoute(
         maintainState: false,
         builder: (context) {
           return  BlueToothSearch(context,fromAddNew: fromAddNew,plant: plant,);
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

   static  gotoEspWithWifi(BuildContext context,int id, BluetoothDevice device,String api_key, List<BluetoothService> services, bool fromAddNew) {
     Navigator.push(context, MaterialPageRoute(
         builder: (context) {
           return EspWithWifi(device: device, api_key: api_key,service: services,id: id,fromAddNew: fromAddNew,);
         }));
   }


   static gotoPlantDataPage(BuildContext context, List<Data> data, String sensorType){
     Navigator.push(context, MaterialPageRoute(
         builder: (context) {
           return PlantDataPage(data: data,sensorType: sensorType,);
         }));
   }



}