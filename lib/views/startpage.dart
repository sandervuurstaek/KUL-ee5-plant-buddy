import 'package:flutter/material.dart';
import 'package:plantbuddy/views/chooseSkillLevel.dart';
import 'package:plantbuddy/views/loginpage.dart';
import 'package:plantbuddy/widgets/imageWidget.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/text.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 710),
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  ImageWidget(imagepath: "asset/startpage.png",
                    //height: 312,
                  ),
                  const SizedBox(height: 48),
                  RoundedButton(data: "Get Started With Plant Buddy", pressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const ChooseSkillLevel(mode: "create Acount");
                    }));

                  },),
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