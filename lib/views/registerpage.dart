
import 'package:flutter/material.dart';

import '../widgets/imageWidget.dart';
import '../widgets/specialButton.dart';
import '../widgets/specifiedTextFormField.dart';
import '../widgets/transparant_appbar.dart';
import 'home.dart';
import 'overview.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({Key? key}) : super(key: key);

    @override
    _RegisterPageState createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
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
          child: RoundedButton(data: "register", pressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Home();
          })); }));


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
              ]
        ),


      );
    }
  }
