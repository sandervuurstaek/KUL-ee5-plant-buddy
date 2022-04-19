import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/ClipperPath.dart';
import 'package:plantbuddy/widgets/LineChartSample.dart';
import 'package:plantbuddy/widgets/LineChartWidget.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../model/Camera.dart';
import '../widgets/imageWidget.dart';
import '../widgets/specialButton.dart';
import '../widgets/transparant_appbar.dart';

class PlantInfo extends StatefulWidget {
  const PlantInfo({Key? key}) : super(key: key);

  @override
  _PlantInfoState createState() => _PlantInfoState();
}

class _PlantInfoState extends State<PlantInfo> {
  File? image;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
          children: [
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipPath(
                    child: image==null?Image.asset("asset/plant3.jpg",fit: BoxFit.cover,
                    width: 1024,
                    height: 300,
                    ): Image.file(image!,fit: BoxFit.cover,
                      width: 1024,
                      height: 300,),
                    clipper: ClipperPath(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        Header1Text("Name",textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        Header2Text("Aloe vera", textStyle: TextStyle(color: Colors.white),),
                        CircleAvatar(
                          radius: 30,
                          child: CameraButton(context),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  )
              ],

              ),
            ),
            SizedBox(height: 40,),
            LineChartSample2(),
            LineChartSample2(),
            LineChartSample2(),

          ],
        ),
    );
  }
}
