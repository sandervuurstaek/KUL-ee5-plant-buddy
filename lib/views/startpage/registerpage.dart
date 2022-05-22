
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/LoadingDialog.dart';
import 'package:plantbuddy/widgets/TextForm.dart';

import '../../model/User.dart';
import '../../widgets/Toast.dart';
import '../../widgets/imageWidget.dart';
import '../../widgets/specialButton.dart';
import '../../widgets/transparant_appbar.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({Key? key}) : super(key: key);

    @override
    _RegisterPageState createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool loading=false;
    TextForm firstnameForm= TextForm(text: "Firstname");
    TextForm lastnameForm= TextForm(text: "Lastname");
    TextForm emailnameForm= TextForm(text: "email");
    PasswordTextForm passwordTextForm=PasswordTextForm(text: "Password");
    PasswordTextForm confirmPasswordForm=PasswordTextForm(text: "Confirm password");

    @override
    Widget build(BuildContext context) {
      //registerImage
      Widget logoImageArea = Container(
        margin:  const EdgeInsets.all(20),
        decoration: CardDecoration(16), 
        child: ImageWidget(imagepath: "asset/registerpage.png",height: 200),
      ) ;

     //input area
      Widget inputTextArea =Container(
        margin:  const EdgeInsets.only(left: 20,right: 20),
        padding: const EdgeInsets.only(top:20,bottom: 20, left: 10,right: 10),
        decoration: CardDecoration(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              firstnameForm,
              const SizedBox(height: 20,),
              lastnameForm,
              const SizedBox(height: 20,),
              emailnameForm,
              const SizedBox(height: 20,),
              passwordTextForm,
              const SizedBox(height: 20,),
              confirmPasswordForm,

            ],
          ),
        ),
      );

      void _tryRegister() async {
        if(_formKey.currentState!.validate())
        {
          enterLoading();
          if(checkpassword())
            {
              await _register(context);
            }

        }
      }


      //register Button
      Widget registerButtonArea =  Container(
          margin:  const EdgeInsets.all(20),
          child: RoundedButton(data: "register", pressed: _tryRegister));


      Widget pagebody= ListView(
          children:[
            logoImageArea,
            inputTextArea,
            registerButtonArea,
          ]
      );



      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const TransparantAppbar(
          title: '',
        ),
        body: !loading?pagebody:LoadingDialog()
      );
    }

    bool checkpassword() => passwordTextForm.passwordEditingController.text==confirmPasswordForm.passwordEditingController.text;

    void enterLoading() {
      setState(() {
        loading=true;
      });
    }

    Future<void> _register(BuildContext context) async {
        runZonedGuarded(() async {
        int code= await User().UserRegister(firstnameForm.textEditingController.text,lastnameForm.textEditingController.text,emailnameForm.textEditingController.text,passwordTextForm.passwordEditingController.text);
      if(code==200)
      {
        //User().updatedInfo=true;
        await getUserInfo(context);
      }
        leaveLoading();
      }, (dynamic e, StackTrace stack){
        ToastDialog.show_toast("Time out, Please try again");
        leaveLoading();
      });
    }

    void leaveLoading() {
      setState(() {
        loading=false;
      });
    }

    Future<void> getUserInfo(BuildContext context) async {
       int code= await User().UserInfo();
      if(code==200)
        {
          RouterManager.toHomepage(context);
        }
    }
  }
