
import 'package:flutter/material.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/specifiedTextFormField.dart';
import 'package:plantbuddy/widgets/text.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';

import '../widgets/imageWidget.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //logoImage
     Widget logoImageArea = const ImageWidget(imagepath: "asset/loginpage.png",height: 200);

    //loginTextForm
     Widget inputTextArea = Container(
       margin:  const EdgeInsets.only(left: 20,right: 20),
       decoration: const BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(8)),
         color: Colors.white
       ),
       child: Form(
         key: _formKey,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: const [
              UserNameTextFormField(),
              SizedBox(height: 10),
             PassWordTextFormField(),
             SizedBox(height: 32),
           ],
         ),
       ),
     );

     //login Button
     Widget loginButtonArea =  Container(
         margin:  const EdgeInsets.only(left: 20,right: 20),
         child: RoundedButton(data: "sign in", pressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) {
       return const Home();
     })); }));

     Widget bottomArea = Container(
       margin:  const EdgeInsets.only(left: 20,right: 20, top:20),
       child: Column(
         children: [
           Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                 width: 100,
                 height: 1,
                 color: Colors.grey,
               ),
               Header3Text("Third party sign in",
                 textStyle: const TextStyle(fontWeight: FontWeight.bold,
                 color: Colors.grey,
                 )
               ),
               Container(
                 width: 100,
                 height: 1,
                 color: Colors.grey,
               ),
             ],
           ),
           const SizedBox(height: 10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               WeChatButton(),
               FacebookButton(),
               GoogleButton(),
             ],
           ),
           const SizedBox(height: 10,),
         TextInButton(pressed: (){}, data: "forget password?")
         ],
       ),
     );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TransparantAppbar(
         title: '',
      ),
      body: ListView(
            children:[
              logoImageArea,
              inputTextArea,
              loginButtonArea,
              bottomArea
            ]
      ),


    );
  }
}
