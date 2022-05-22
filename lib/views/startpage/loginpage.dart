
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plantbuddy/controller/RouterManager.dart';
import 'package:plantbuddy/model/User.dart';
import 'package:plantbuddy/widgets/Decoration/CardDecoration.dart';
import 'package:plantbuddy/widgets/LoadingDialog.dart';
import 'package:plantbuddy/widgets/TextForm.dart';
import 'package:plantbuddy/widgets/Toast.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
import 'package:plantbuddy/widgets/transparant_appbar.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading=false;
  TextForm emailTextForm = TextForm(text: 'email');
  PasswordTextForm passwordTextForm= PasswordTextForm(text: 'password');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _tryLogin() async {
    print(DateTime.now().toString());
    if(_formKey.currentState!.validate() )
      {
        _enterLoading();
        runZonedGuarded(() async {
          await _login();
          _leaveLoading();
        }, _loginErrorHandler);
      }
  }

  Future<void> _login() async {
      int code= await User().UserLogin(emailTextForm.textEditingController.text, passwordTextForm.passwordEditingController.text);
            if(code==200)
            {
    await _getUserInfo();
            }
  }

  Future<void> _getUserInfo() async {
    int code= await User().UserInfo();
    if(code==200)
    {
      print(User().token);
      RouterManager.toHomepage(context);
    }
  }

  void _loginErrorHandler(dynamic e, StackTrace stack){
    //ToastDialog.show_toast("Time out, Please try again");
    print(e);
    print(stack);
    ToastDialog.show_toast(e.toString());
    _leaveLoading();
  }

  void _leaveLoading() {
    setState(() {
      loading=false;
    });
  }

  void _enterLoading() {
    setState(() {
      loading=true;
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget logoImage=Container(
      constraints: BoxConstraints(maxWidth: 200),
      margin:  const EdgeInsets.only(left: 20,right: 20),
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: AssetImage('asset/login.jpg'),
            fit: BoxFit.fitWidth,
       )
      ),
    );

    Widget inputTextArea = Container(
      margin:  const EdgeInsets.only(left: 20,right: 20),
      padding: const EdgeInsets.only( top: 20 ,bottom: 20),
      decoration: CardDecoration(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //logoImage,
            Container(margin:  const EdgeInsets.all( 16),child: emailTextForm),
            Container(margin:  const EdgeInsets.all( 16),child: passwordTextForm)
          ],

        ),
      ),
      
    );

     //login Button
     Widget loginButtonArea =  Container(
         margin:  const EdgeInsets.only(left: 20,right: 20),
         child: RoundedButton(data: "sign in", pressed: _tryLogin));

     Widget pagebody= ListView(
           children:[
             SizedBox(height: 20,),
             logoImage,
             SizedBox(height: 20,),
             inputTextArea,
             SizedBox(height: 20,),
             loginButtonArea,
           ]
       );



    return !loading?Scaffold(
        appBar: const TransparantAppbar(
           title: '',
        ),
        body:Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: pagebody
          ),
        ),

      ):LoadingDialog();
  }


}
