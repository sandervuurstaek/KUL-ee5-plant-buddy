import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../model/Camera.dart';

class RoundedButton extends ElevatedButton {
  final String data;
  final void Function() pressed;
  RoundedButton({Key? key, required this.data, required this.pressed}) : super(
      key: key,
    style: ButtonStyle(

      //backgroundColor: Theme.of(context).theme,
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32))),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Header2Text(
        data,
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
      onPressed: pressed
  );
}

class GoBackButton extends IconButton{
  final BuildContext context;
  GoBackButton(this.context, {Key? key}) : super(key: key,
    onPressed: () => Navigator.of(context).pop(),
    icon: const Icon(
      Icons.arrow_back,
      color: Colors.black,
    ),);

}

class WeChatButton extends IconButton{
  WeChatButton({Key? key}) : super(key: key,
    onPressed: (){

    },
    icon: const Icon(FontAwesomeIcons.weixin),
    color: Colors.green[200],
    iconSize: 40,);
}

class FacebookButton extends IconButton{
  FacebookButton({Key? key}) : super(key: key,
    onPressed: (){

    },
    icon: const Icon(FontAwesomeIcons.facebook),
    color: Colors.green[200],
    iconSize: 40,);
}

class GoogleButton extends IconButton{
  GoogleButton({Key? key}) : super(key: key,
    onPressed: (){

    },
    icon: const Icon(FontAwesomeIcons.google),
    color: Colors.green[200],
    iconSize: 40,);
}

class CameraButton extends IconButton{
  final BuildContext context;
  CameraButton(this.context,{Key? key}) : super(key: key,
  onPressed: (){
    Camera.changePhoto(context);
  },
  icon: Icon(Icons.camera_alt_rounded),
  color: Colors.grey,
    iconSize: 36,)
  ;

}

class TextInButton extends TextButton{
  final String data;
  final void Function() pressed;
  TextInButton({Key? key, required this.data, required this.pressed}) : super(key: key, onPressed: pressed,
      child: Header3Text(
        data,
      ));

}
