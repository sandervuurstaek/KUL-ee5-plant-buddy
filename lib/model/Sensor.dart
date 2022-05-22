
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Sensor{

  static String getSensorType(int sensorId){
    String SensorType;
    switch(sensorId){
      case 1: {
        SensorType="Temperature";
      }
      break;

      case 2 : {
        SensorType="Pressure";
      }
      break;

      case 3: {
        SensorType="IAQ";
      }
      break;

      case 4 :{
        SensorType="LDR";
      }
      break;

      case 5 :{
        SensorType="Water_Level";
      }
      break;

      case 6: {
        SensorType="Moisture";
      }
      break;

      case 7: {
        SensorType="Humidity";
      }
      break;

      default: {
        SensorType="UnKnown";
      }
    }

    return SensorType;
  }

  static String getSensorUnit(String type){
      String unit;
      switch(type){
        case "Temperature": {
          unit="°C";
        }
        break;

        case "Pressure": {
          unit="Pa";
        }
        break;

        case "IAQ": {
          unit="";
        }
        break;

        case "LDR" :{
          unit="%";
        }
        break;

        case "Water_Level" :{
          unit="%";
        }
        break;

        case "Moisture": {
          unit="%";
        }
        break;

        case "Humidity": {
          unit="%";
        }
        break;

        default: {
          unit="";
        }
      }

      return unit;

  }

  static Color getSensorColor(String type){
    Color color;
    switch(type){
      case "Temperature": {
        color =Colors.red;
      }
      break;

      case "Pressure": {
        color =Colors.pink;
      }
      break;

      case "IAQ": {
        color =Colors.blueGrey;
      }
      break;

      case "LDR" :{
        color =Colors.deepOrange;
      }
      break;

      case "Water_Level" :{
        color =Colors.lightBlueAccent;
      }
      break;

      case "Moisture": {
        color =Colors.greenAccent;
      }
      break;

      case "Humidity": {
        color =Colors.blueAccent;
      }
      break;

      default: {
        color=Colors.green;
      }
    }

    return color;
  }


  static Widget getSensorIcon(String type, double size){
    Widget icon;
    switch(type){
      case "Temperature": {
        icon =BoxedIcon(WeatherIcons.thermometer,color: getSensorColor("Temperature"),size: size,);
      }
      break;

      case "Pressure": {
        icon =Icon(Icons.sensors_rounded,color: getSensorColor("Pressure"), size: size,);
      }
      break;

      case "IAQ": {
        icon =Icon(Icons.air_rounded,color: getSensorColor("IAQ"), size: size,);
      }
      break;

      case "LDR" :{
        icon =Icon(Icons.light,color: getSensorColor("LDR"), size: size,);
      }
      break;

      case "Water_Level" :{
        icon =BoxedIcon(WeatherIcons.raindrop,color: getSensorColor("Water_Level"),size: size,);
      }
      break;

      case "Moisture": {
        icon =BoxedIcon(WeatherIcons.flood,color: getSensorColor("Moisture"),size: size,);
      }
      break;

      case "Humidity": {
        icon =BoxedIcon(WeatherIcons.humidity,color: getSensorColor("Humidity"),size: size,);
      }
      break;

      default: {
        icon=BoxedIcon(WeatherIcons.humidity,color: getSensorColor("Humidity"),size: size,);
      }
    }

    return icon;
  }


  static List<Color> getSensorGradientColors(String type){
    List<Color> gradientColors;
    switch(type){
      case "Temperature": {
        gradientColors =[
          getSensorColor("Temperature"),
        ];
      }
      break;

      case "Pressure": {
        gradientColors =[
          getSensorColor("Pressure")
        ];
      }
      break;

      case "IAQ": {
        gradientColors =[
          getSensorColor("IAQ")
        ];
      }
      break;

      case "LDR" :{
        gradientColors =[
          getSensorColor("LDR")
        ];
      }
      break;

      case "Water_Level" :{
        gradientColors =[
          getSensorColor("Water_Level")
        ];
      }
      break;

      case "Moisture": {
        gradientColors =[
          getSensorColor("Moisture")
        ];
      }
      break;

      case "Humidity": {
        gradientColors =[
          getSensorColor("Humidity")
        ];
      }
      break;

      default: {
        gradientColors=[getSensorColor("Temperature")];
      }
    }

    gradientColors.add(gradientColors[0]);
    return gradientColors;
  }


}