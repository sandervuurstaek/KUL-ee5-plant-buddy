import 'package:flutter/material.dart';
import 'package:plantbuddy/views/loginpage.dart';
import 'package:plantbuddy/views/registerpage.dart';
import 'package:plantbuddy/widgets/imageWidget.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/text.dart';

import '../widgets/ClipperPath.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 710),
              //padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  ClipPath(
                    child: Image.asset("asset/startpage.png",fit: BoxFit.cover,
                      width: 1024,
                      height: 500,),
                    clipper: ClipperPath(),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child: RoundedButton(data: "Get Started", pressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const RegisterPage();
                      }));

                    },),
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const Login();
                        }));
                      },
                      child: Header3Text(
                        "Aready a member? Sign in here",
                        textStyle: const TextStyle(
                          color: Colors.black45,
                        ),
                      )),
                ],
              ),
            ),

      ),
    );
  }
}