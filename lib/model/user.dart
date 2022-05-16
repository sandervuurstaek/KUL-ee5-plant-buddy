

import 'dart:convert';
import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantbuddy/controller/RestRequestHandler.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:plantbuddy/model/Plant.dart';

import '../widgets/Toast.dart';

class User {

  static final User _userinstance=User._createUser();
  String? token;
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  List<Plant> plants=[];
 // bool updatedInfo=true;

  User._createUser();
  factory User()=>_userinstance;




  Future<dynamic> UserLogin(String email,String password) async {

    return RestRequestHandler.make_database_rest_request().httpPost(
      path: "/api/auth/login",
      queryParameters: {
        "email": email,
        "password": password,
      },
      headers: {
        'Content-Type': 'application/json',
      },
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
    headers: {'Content-Type': 'application/json'},
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        token=json["token"];
        _getIdFromToken(token);
        //AuthManager.logined();
        ToastDialog.show_toast("succefully registered");
      }
      else{
        ToastDialog.show_toast("register failed");
      }
      return response.statusCode;
    });
  }


  Future<dynamic> getPlants() async {
    return RestRequestHandler.make_database_rest_request().httpGet(
      path: "/api/user/${id}/devices",
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      },
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
      else{
        ToastDialog.show_toast("Failed");
      }
    });
  }



Future<dynamic> User_get_measurement(int deviceId) async
{
  return RestRequestHandler.make_database_rest_request().httpGet(
    path: "/api/user/$id/measurement",
    queryParameters: {
      "deviceId": deviceId.toString(),
      "limit": 20.toString(),
    },
    headers: {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    },
  ).then((response) {
    if(response.statusCode==200)
    {
      ToastDialog.show_toast("get data");
      var data=jsonDecode(response.body);
      return data;
    }
    else{
      ToastDialog.show_toast("Failed");
    }
  },
      onError: on_error);
}

  Future<dynamic> UserInfo(){
    return RestRequestHandler.make_database_rest_request().httpGet(
      path: "/api/user/$id",
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    ).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> json = jsonDecode(response.body);
        _getUserInfoFromJson(json);
        //AuthManager.logined();
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
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'
      }
    ).then(
            (response) async {
          if (response.statusCode == 200) {
            ToastDialog.show_toast("Deleted");
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
        "picture" : {}
      },
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'},
    ).then((response) async {
      var api_key;
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        List json = jsonDecode(response.body);
        api_key=json[0]["api_key"];
        ToastDialog.show_toast("Saved");
      }
      else if(response.statusCode==422)
        {
          ToastDialog.show_toast("Device already registered");
        }
      else{
        ToastDialog.show_toast("Save device failed");
      }
      return api_key;
    });
  }


  Future<dynamic> UserUpdate_device(int deviceID,  String pic, String deviceName) async
  {
    return RestRequestHandler.make_database_rest_request().httpPut(
      path: "/api/user/$id/devices",
      queryParameters: {
        "deviceId": deviceID.toString(),
      },
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json'},
      data: {
        "device_name" : deviceName,
        "picture" : pic
      }
    ).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200) {
        ToastDialog.show_toast("Saved change");
      }
     else{
        ToastDialog.show_toast("Failed to change");
      }
      return response.statusCode;
    });
  }




  void _getUserAuthFromJson(Map<String, dynamic> json) {
     token=json["token"];
     id=json["id"];
   // _getIdFromToken(token!);
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

}