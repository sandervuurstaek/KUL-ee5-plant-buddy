

import 'dart:convert';

import 'package:plantbuddy/controller/RestRequestHandler.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:plantbuddy/model/Plant.dart';

import '../widgets/Toast.dart';

class User {

  static final User _userInstance=User._createUser();
  late String token;
  late int id;
  late String firstname;
  late String lastname;
  late String email;
  List<Plant> plants=[];


  User._createUser();
  factory User()=>_userInstance;




  Future<dynamic> UserLogin(String email,String password) async {

    return RestRequestHandler.make_database_rest_request().httpPost(
      path: "/api/auth/login",
      queryParameters: {
        "email": email,
        "password": password,
      },
      headers: _getHeader(false),
    ).then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        _getUserAuthFromJson(json);
      }
      else{
        ToastDialog.show_toast("Login Failed");
      }
      return response.statusCode;
    });

  }

  Future<dynamic> UserRegister(String firstname, String lastname, String email, String password) async{
    return RestRequestHandler.make_database_rest_request().httpPost(
        path: "/api/auth/register",
    queryParameters: {
          "firstname": firstname,
           "lastname": lastname,
            "email" : email,
             "password": password,
    },
    headers: _getHeader(false),
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        token=json["token"];
        _getIdFromToken(token);
        ToastDialog.show_toast("Successfully registered");
      }
      else{
        ToastDialog.show_toast("Register Failed");
      }
      return response.statusCode;
    });
  }


  Future<dynamic> User_get_Plants() async {
    return RestRequestHandler.make_database_rest_request().httpGet(
      path: "/api/user/$id/devices",
      headers: _getHeader(true),
    ).then((response) {
      if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
        return data;
      }
      else if(response.statusCode==404)
      {
        ToastDialog.show_toast("You should add plants");
      }
      else if(response.statusCode==401)
        {
          ToastDialog.show_toast("Your token is expired, please log in again");
        }
      else{
        ToastDialog.show_toast(response.statusCode.toString());
        ToastDialog.show_toast("Failed");
      }
    }
    );
  }

  Map<String, String> _getHeader(bool withToken) {
    if(withToken)
      {
        return {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        };
      }
    else
      {
        return {
          'Content-Type': 'application/json'
        };
      }

  }







Future<dynamic> User_get_measurement(int deviceId) async
{
  return RestRequestHandler.make_database_rest_request().httpGet(
    path: "/api/user/$id/measurement",
    queryParameters: {
      "deviceId": deviceId.toString(),
      "limit": 1000.toString(),
    },
    headers: _getHeader(true),
  ).then((response) {
    if(response.statusCode==200)
    {
      var data=jsonDecode(response.body);
      return data;
    }
    else if(response.statusCode==401)
    {
      ToastDialog.show_toast("Your token is expired, please log in again");
    }
    else{
      ToastDialog.show_toast("Failed to get data");
    }
  },
      onError: on_error);
}



  Future<dynamic> UserInfo(){
    return RestRequestHandler.make_database_rest_request().httpGet(
      path: "/api/user/$id",
      headers: _getHeader(true),
    ).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        _getUserInfoFromJson(json);
      }
      else if(response.statusCode==401)
      {
        ToastDialog.show_toast("Your token is expired, please log in again");
      }
      else{
        ToastDialog.show_toast("Unable to get User information");
      }
      return response.statusCode;
    });

  }

  Future<dynamic> User_delete_device(int deviceId) async
  {
    return RestRequestHandler.make_database_rest_request().httpDelete(
      path: "/api/user/${id}/devices",
        queryParameters: {
        'deviceId': deviceId.toString(),
        },
      headers: _getHeader(true)
    ).then(
            (response) async {
          if (response.statusCode == 200) {
            ToastDialog.show_toast("Deleted");
          }
          else if(response.statusCode==401)
          {
            ToastDialog.show_toast("Your token is expired, please log in again");
          }
          else
          {
            ToastDialog.show_toast("Delete Failed");
          }
          return response.statusCode;
        },
        onError: on_error
    );
  }

  on_error(e, stack){
    print(stack);
    print(e.message);
    ToastDialog.show_toast(e.toString());
      }
      
      
  Future<dynamic> UserAdd_new_device(String deviceName, String deviceIdentifier) async
  {
    return RestRequestHandler.make_database_rest_request().httpPost(
      path: "/api/user/$id/devices",
      queryParameters: {
        "device_name": deviceName,
        "device_identifier": deviceIdentifier,
        "picture" : null
      },
      headers: _getHeader(true)
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List json = jsonDecode(response.body);
        ToastDialog.show_toast("Saved");
        return json;
      }
      else if(response.statusCode==401)
      {
        ToastDialog.show_toast("Your token is expired, please log in again");
      }
      else if(response.statusCode==422)
        {
          ToastDialog.show_toast("Device already registered");
        }
      else{
        ToastDialog.show_toast("Save device failed");
      }
      return [];
    });
  }



  Future<dynamic> UserUpdate_device(int deviceID,  String pic, String deviceName) async
  {
    return RestRequestHandler.make_database_rest_request().httpPut(
      path: "/api/user/$id/devices",
      queryParameters: {
        "deviceId": deviceID.toString(),
      },
      headers: _getHeader(true),
      data: {
        "device_name" :deviceName,
        "picture" : pic
      }
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        ToastDialog.show_toast("Saved change");
      }
      else if(response.statusCode==401)
      {
        ToastDialog.show_toast("Your token is expired, please log in again");
      }
      else if(response.statusCode==400)
        {
          ToastDialog.show_toast("Invalid ${response.body}");
        }
     else{
        ToastDialog.show_toast("Failed to change");
      }
      return response.statusCode;
    });
  }




  void _getUserAuthFromJson(Map<String, dynamic> json) {
     token=json["token"];
     print(token);
     id=json["id"];
  }

  void _getUserInfoFromJson(List<dynamic> json){
    firstname=json[0]["firstname"];
    lastname=json[0]["lastname"];
    email=json[0]["email"];
  }

  _getIdFromToken(String? token)
  {
    if(token!=null)
      {
        Map<String,dynamic> decodedToken=Jwt.parseJwt(token);
        id=decodedToken['user']['id'];
      }
  }

  bool checkTokenExpired()
  {
    if(token==null)
      {
        return true;
      }
    else
      {
        return Jwt.isExpired(token);
      }
  }

}