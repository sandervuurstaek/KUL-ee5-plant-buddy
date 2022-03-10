
import 'package:flutter/material.dart';

class UserNameTextFormField extends StatefulWidget {
  const UserNameTextFormField({Key? key}) : super(key: key);
  @override
  _UserNameTextFormFieldState createState() => _UserNameTextFormFieldState();
}

class _UserNameTextFormFieldState extends State<UserNameTextFormField> {
  final TextEditingController textEditingController= TextEditingController();
  var _isShowClear = false;
  @override
  void initState(){
    textEditingController.addListener(() {
      if(textEditingController.text.isNotEmpty){
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
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        border:  const OutlineInputBorder(
            borderRadius: BorderRadius.all( Radius.circular(8)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 2
            )
        ),
        labelText: "Username",
        hintText: "phone number/email",
        prefixIcon: const Icon(Icons.person),
        suffixIcon: (_isShowClear)? IconButton(onPressed: (){
          textEditingController.clear();
        }, icon: const Icon(Icons.clear)):null,
      ),
    );
  }
}



class PassWordTextFormField extends StatefulWidget {
  const PassWordTextFormField({Key? key}) : super(key: key);
  @override
  _PassWordTextFormFieldState createState() => _PassWordTextFormFieldState();
}

class _PassWordTextFormFieldState extends State<PassWordTextFormField> {
  var _passwordVisible = false;
  @override
  void initState(){
    _passwordVisible=false;
    super.initState();
  }

  void changeVisible(){
    _passwordVisible=!_passwordVisible;
  }

  String validatorPassWord(value){
    if(value.toString().isEmpty){
      return 'password can not be empty';
    }else if(value.toString().trim().length<6 || value.toString().trim().length>18)
      {
        return 'invalid password length';
      }
    return null.toString();
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _passwordVisible,
      validator: validatorPassWord,
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
    );
  }
}



