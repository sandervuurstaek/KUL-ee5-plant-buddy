

import 'dart:io';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantbuddy/controller/RestRequestHandler.dart';

class User {
  static final User _userinstance=User._createUser();
  String? token;


  User._createUser();
  factory User()=>_userinstance;


  Future<int> UserLogin(String email,String password) async {
    return RestRequestHandler().databaseRestrequest.httpPost(
      path: "/api/auth/login",
      queryParameters: {
        "email": email,
        "password": password,
      },
      headers: {'Content-Type': 'application/json'},
    ).then((response) async {

      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        token=json["token"][0];
        //AuthManager.logined();
        Fluttertoast.showToast(
            msg: "succefully logined",  // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM,    // location// duration
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "login failed",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location// duration
        );
      }
      return response.statusCode;
    });

  }

  Future<int> UserRegister(String firstname, String lastname, String email, String password) async{
    return RestRequestHandler().databaseRestrequest.httpPost(
        path: "/api/auth/register",
    queryParameters: {
          "firstname": firstname,
           "lastname": lastname,
            "email" : email,
             "password": password,
    },
    headers: {'Content-Type': 'application/json'},
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        token=json["token"][0];
        //AuthManager.logined();
        Fluttertoast.showToast(
          msg: "succefully registered",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location// duration
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "register failed",  // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.BOTTOM,    // location// duration
        );
      }
      return response.statusCode;
    });

  }

}