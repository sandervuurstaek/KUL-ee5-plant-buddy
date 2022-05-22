
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/text.dart';


class RoundedButton extends ElevatedButton {
  final String data;
  final void Function() pressed;

  RoundedButton({Key? key, required this.data, required this.pressed}) : super(
      key: key,
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16))),
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





class CameraButton extends IconButton{
  final BuildContext context;
  CameraButton(this.context,{Key? key}) : super(key: key,
  onPressed: (){

  },
  icon: Icon(Icons.camera_alt_rounded),
  color: Colors.white,
    iconSize: 48,)
  ;

}
//ignore: must_be_immutable
class TextInButton extends TextButton{
  final String data;
  final void Function() pressed;
  Color color;
  TextInButton({Key? key, required this.data, required this.pressed, required this.color}) : super(key: key, onPressed: pressed,
      child: Header3Text(
        data,
        textStyle: TextStyle(color: color),
      ));

}
