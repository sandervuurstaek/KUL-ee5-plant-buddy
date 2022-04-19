
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbuddy/model/user.dart';
import 'package:plantbuddy/widgets/specialButton.dart';
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
  bool loading=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailEditingController= TextEditingController();
  var _isShowClear = false;
  var _passwordVisible = false;
  final TextEditingController passwordEditingController= TextEditingController();


  @override
  void initState(){
    loading=false;
    emailEditingController.addListener(() {
      if(emailEditingController.text.isNotEmpty){
        _isShowClear = true;
      }
      else{
        _isShowClear =false;
      }
      setState(() {
      });
    });
    _passwordVisible=false;
    passwordEditingController.addListener(() { });
    super.initState();
  }
  @override
  void dispose(){
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }
  void changeVisible(){
    _passwordVisible=!_passwordVisible;
  }

  String? _validatorPassWord(value){
    if(value == null || value.isEmpty){
      return 'password can not be empty';
    }
    return null;
  }

  String? _validatoremail(value){
    if(value == null || value.isEmpty){
      return 'email can not be empty';
    }
    return null;
  }

  void _tryLogin() async {
    if(_formKey.currentState!.validate())
      {
        print(emailEditingController.text);
        print(passwordEditingController.text);
        int code= await User().UserLogin(emailEditingController.text, passwordEditingController.text);
        if(code==200)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Home();
          }));
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    //logoImage
     Widget logoImageArea = const ImageWidget(imagepath: "asset/loginpage.png",height: 200);


     Widget inputTextArea =Container(
       margin:  const EdgeInsets.only(left: 20,right: 20),
       decoration: const BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(8)),
           color: Colors.white
       ),
       child: Form(
         key: _formKey,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children:  [
             TextFormField(
               validator: _validatoremail,
               controller: emailEditingController,
               decoration: InputDecoration(
                 border:  const OutlineInputBorder(
                     borderRadius: BorderRadius.all( Radius.circular(8)),
                     borderSide: BorderSide(
                         color: Colors.grey,
                         width: 2
                     )
                 ),
                 labelText: "email",
                 hintText: "email",
                 prefixIcon: const Icon(Icons.person),
                 suffixIcon: (_isShowClear)? IconButton(onPressed: (){
                   emailEditingController.clear();
                 }, icon: const Icon(Icons.clear)):null,
               ),
             ),
             const SizedBox(height: 10),
             TextFormField(
               controller: passwordEditingController,
               obscureText: _passwordVisible,
               validator: _validatorPassWord,
               decoration: InputDecoration(
                   border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all( Radius.circular(8)),
                       borderSide: BorderSide(
                           color: Colors.grey,
                           width: 2
                       )
                   ),
                   labelText: "Password",
                   hintText: "Please enter password",
                   prefixIcon: const Icon(Icons.lock),
                   suffixIcon: IconButton(
                       icon: Icon((_passwordVisible)?Icons.visibility: Icons.visibility_off),
                       onPressed: (){
                         setState(changeVisible);
                       }
                   )
               ),
             ),
             const SizedBox(height: 32),
           ],
         ),
       ),
     );



     //login Button
     Widget loginButtonArea =  Container(
         margin:  const EdgeInsets.only(left: 20,right: 20),
         child: RoundedButton(data: "sign in", pressed: _tryLogin));






     Widget bottomArea = Container(
       margin:  const EdgeInsets.only(left: 20,right: 20, top:20),
       child: Column(
         children: [
           Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                 width: 80,
                 height: 1,
                 color: Colors.grey,
               ),
               Header3Text("Third party sign in",
                 textStyle: const TextStyle(fontWeight: FontWeight.bold,
                 color: Colors.grey,
                 )
               ),
               Container(
                 width: 80,
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
      body: loading?CupertinoActivityIndicator(
        radius: 50,
      ): ListView(
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
