
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/model/user.dart';

import '../views/home.dart';

class RouterManager{

   static Login(context, String email, String password) async {
     User().UserLogin(email, password);
     Navigator.push(context, MaterialPageRoute(builder: (context) {
       return const Home();
     }));

   }


}