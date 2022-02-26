import 'package:flutter/material.dart';
import 'package:plantbuddy/ui/loginpage.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          const SizedBox( height: 150),
          Container(
            alignment: Alignment.center,
            child: Image.asset("asset/startpage.png"),
          ),
          const SizedBox( height: 30),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(10),
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(
                    18, 144, 122, 1.0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35))),
              ),
              child: const Text("Get Started With Plant Buddy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18
                ),
              ),
              onPressed: (){
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10,left: 20,right: 20),
            child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Login();
                  }));
                },
                child: Text(
                  "Aready a member? Sign in here",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16.0,
                  ),
                )),
          )


        ],
      ),
    );
  }
}