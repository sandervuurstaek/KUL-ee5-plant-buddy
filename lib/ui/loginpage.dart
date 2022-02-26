
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNodeUserName =  FocusNode();
  final FocusNode _focusNodePassword =  FocusNode();
  final TextEditingController _userNameController= TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password;
  var _username;
  var _passwordVisible = false;
  var _isShowClear = false;

  @override
  void initState(){
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassword.addListener(_focusNodeListener);

    _userNameController.addListener(() {
      print(_userNameController.text);
      if(_userNameController.text.length>0){
        _isShowClear = true;
      }
      else{
        _isShowClear =false;
      }
      setState(() {

      });
    });
    super.initState();
  }
  @override
  void dispose(){
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassword.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  Future<Null> _focusNodeListener()async{
    if(_focusNodeUserName.hasFocus){
      print("UserName get focus");
      _focusNodePassword.unfocus();
    }
    if(_focusNodePassword.hasFocus){
      print("Password get focus");
      _focusNodeUserName.unfocus();
    }
  }

  Widget build(BuildContext context) {


     Widget logoImageArea = Container(
       margin: EdgeInsets.only(left: 20,right: 20),
       width: double.infinity,
       alignment: Alignment.center,
       child:  Image.asset("asset/loginpage.png",
         height: 200,
       ),
     );

     Widget inputTextArea = Container(
       margin: const EdgeInsets.only(left: 20,right: 20),
       decoration: const BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(8)),
         color: Colors.white
       ),
       child: Form(
         key: _formKey,
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             TextFormField(
               controller: _userNameController,
               focusNode: _focusNodeUserName,
               decoration: InputDecoration(
                 border: const OutlineInputBorder(
                   borderRadius: BorderRadius.all( Radius.circular(10)),
                   borderSide: BorderSide(
                     color: Colors.grey,
                     width: 2.0
                   )
                 ),
                 labelText: "Username",
                 hintText: "phone number/email",
                 prefixIcon: const Icon(Icons.person),
                 suffixIcon: (_isShowClear)? IconButton(onPressed: (){
                   _userNameController.clear();
                 }, icon: const Icon(Icons.clear)):null,
               ),
               onSaved: (value){
                 _username=value;
               },
             ),
             const SizedBox(height: 10,),
             TextFormField(
               focusNode: _focusNodePassword,
               obscureText: _passwordVisible,
               decoration: InputDecoration(
                   border: const OutlineInputBorder(
                       borderRadius: BorderRadius.all( Radius.circular(10)),
                       borderSide: BorderSide(
                           color: Colors.grey,
                           width: 2.0
                       )
                   ),
                 labelText: "Password",
                 hintText: "Please enter password",

                 prefixIcon: const Icon(Icons.lock),
                 suffixIcon: IconButton(
                   icon: Icon((_passwordVisible)?Icons.visibility: Icons.visibility_off),
                   onPressed: (){
                     setState(() {
                       _passwordVisible=!_passwordVisible;
                     });
                   },
                 )
               ),
               onSaved: (value){
                 _password=value;
               },
               )
           ],
         ),


       ),
     );

     Widget loginButtonArea = Container(
       margin: const EdgeInsets.only(left: 20,right: 20, top:40),
       height: 50,
       width: double.infinity,
       child: ElevatedButton(
         style: ButtonStyle(
           elevation: MaterialStateProperty.all(10),
           backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
               18, 144, 122, 1.0)),
           shape: MaterialStateProperty.all(RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(35))),
         ),
         child: const Text("sign in",
           style: TextStyle(
               fontWeight: FontWeight.bold,
               color: Colors.white,
               fontSize: 20
           ),
         ),
         onPressed: (){
         },
       ),
     );

     Widget thridLoginArea = Container(
       margin: const EdgeInsets.only(left: 20,right: 20, top: 30),
       child: Column(
         children: [
           Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(
                 width: 80,
                 height: 1.0,
                 color: Colors.grey,
               ),
               const Text("Third party sign in",
                 style: TextStyle(fontWeight: FontWeight.bold,
                 color: Colors.grey,
                 fontSize: 15,
                 )
               ),
               Container(
                 width: 80,
                 height: 1.0,
                 color: Colors.grey,
               ),
             ],
           ),
           const SizedBox(
             height: 18,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               IconButton(
                   onPressed: (){
               },
                   icon: Icon(FontAwesomeIcons.weixin),
                 color: Colors.green[200],
                 iconSize: 40.0,
               ),
               IconButton(
                 onPressed: (){
                 },
                 icon: Icon(FontAwesomeIcons.facebook),
                 color: Colors.green[200],
                 iconSize: 40.0,
               ),
               IconButton(
                 onPressed: (){
                 },
                 icon: const Icon(FontAwesomeIcons.google),
                 color: Colors.green[200],
                 iconSize: 40.0,
               ),
             ],
           )
         ],
       ),
     );

     Widget bottomArea = Container(
       margin: const EdgeInsets.only(left: 20,right: 20, top: 20),
       child:
           TextButton(onPressed: (){}, child: Text(
             "forget password?",
             style: TextStyle(
               color: Colors.blue[400],
               fontSize: 16.0,
             ),
           )
       ),
     );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){
          _focusNodeUserName.unfocus();
          _focusNodePassword.unfocus();
        },
        child: ListView(
          children:[logoImageArea,
            inputTextArea,
            loginButtonArea,
            thridLoginArea,
            bottomArea]
          ),
      ),

    );
  }
}
