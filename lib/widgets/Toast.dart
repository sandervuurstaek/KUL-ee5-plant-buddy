import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastDialog {
  static show_toast(String content){
    Fluttertoast.showToast(
      msg: content,  // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,// location// duration
      textColor: Colors.black
    );
  }
}
