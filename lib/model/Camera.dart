
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/ActionSheet.dart';
import '../widgets/text.dart';

class Camera {

  static changePhoto(BuildContext context) async {
    await showCupertinoModalPopup(context: context, builder: (context)=>actionSheet("Photo", context,  [ CupertinoActionSheetAction(onPressed:(){
      getImageFromGallery();
      Navigator.of(context).pop();
    } , child: Header3Text("Choose from gallery",textStyle: const TextStyle(
      color: Colors.blueAccent,
    ) )),
       CupertinoActionSheetAction(onPressed:(){
        Navigator.of(context).pop();
        getImageFromCamera();
      } , child: Header3Text("Take photo",textStyle: const TextStyle(
        color: Colors.blueAccent,
      ) ))]));
  }

  static Future getImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null)
    {
      final imageFile = File(image.path);
      return imageFile;
    }
    else{
      return null;
    }
  }

  static Future getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null)
      {
        final imageFile = File(image.path);
        return imageFile;
      }
    else{
      return null;
    }

  }

}