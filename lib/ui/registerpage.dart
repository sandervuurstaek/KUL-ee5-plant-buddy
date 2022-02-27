
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({Key? key}) : super(key: key);

    @override
    _RegisterPageState createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    final FocusNode _focusNodeUserName =  FocusNode();
    final FocusNode _focusNodePassword =  FocusNode();
    final FocusNode _focusNodeConfrimPass = FocusNode();
    final TextEditingController _userNameController= TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    var _password;
    var _username;
    var _passwordVisible = true;
    var _isShowClear = false;

    @override
    void initState(){
      _focusNodeUserName.addListener(_focusNodeListener);
      _focusNodePassword.addListener(_focusNodeListener);
      _focusNodeConfrimPass.addListener(_focusNodeListener);

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
      _focusNodeConfrimPass.removeListener(_focusNodeListener);
      _userNameController.dispose();
      super.dispose();
    }

    Future<Null> _focusNodeListener()async{
      if(_focusNodeUserName.hasFocus){
        _focusNodePassword.unfocus();
        _focusNodeConfrimPass.unfocus();
      }
      else if(_focusNodePassword.hasFocus){
        _focusNodeUserName.unfocus();
        _focusNodeConfrimPass.unfocus();
      }
      else if(_focusNodeConfrimPass.hasFocus){
        _focusNodeUserName.unfocus();
        _focusNodePassword.unfocus();
      }
    }

    Widget build(BuildContext context) {

      Widget logoImageArea = Container(
        margin: EdgeInsets.only(left: 60.w,right: 60.w),
        width: double.infinity,
        alignment: Alignment.center,
        child:  Image.asset("asset/loginpage.png",
          height: 600.h,
        ),
      );

      Widget inputTextArea = Container(
        margin:  EdgeInsets.only(left: 60.w,right: 60.w),
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
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.all( Radius.circular(30.r)),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 6.0.r
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
              SizedBox(height: 30.h),
              TextFormField(
                focusNode: _focusNodePassword,
                obscureText: _passwordVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all( Radius.circular(30.r)),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 6.0.r
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
              ),
              SizedBox(height: 30.h),
              TextFormField(
                focusNode: _focusNodeConfrimPass,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all( Radius.circular(30.r)),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 6.0.r
                        )
                    ),
                    labelText: "Confirm Password",
                    hintText: "Please enter password again",

                    prefixIcon: const Icon(Icons.lock),
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
        margin:  EdgeInsets.only(left: 60.w,right: 60.w, top:80.h),
        height: 150.h,
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
                18, 144, 122, 1.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r))),
          ),
          child: Text("Create Account",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 60.sp
            ),
          ),
          onPressed: (){
          },
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
            _focusNodeConfrimPass.unfocus();
          },
          child: ListView(
              children:[logoImageArea,
                inputTextArea,
                loginButtonArea,
                ]
          ),
        ),

      );
    }
  }
