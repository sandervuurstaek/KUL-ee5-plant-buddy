
import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
 final String text;
  final TextEditingController textEditingController= TextEditingController();

  TextForm({Key? key, required this.text}) : super(key: key);

  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  var _isShowClear = false;
  @override
  void initState(){
    super.initState();
    widget.textEditingController.addListener(() {
      if(widget.textEditingController.text.isNotEmpty){
        _isShowClear = true;
      }
      else{
        _isShowClear =false;
      }
      setState(() {
      });
    });
  }


  String? _validatortext(value){
    if(value == null || value.isEmpty){
      return 'Not be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
        validator: _validatortext,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          border:  const OutlineInputBorder(
              borderRadius: BorderRadius.all( Radius.circular(8)),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2
              )
          ),
          labelText: widget.text,
          prefixIcon: const Icon(Icons.person),
          suffixIcon: (_isShowClear)? IconButton(onPressed: (){
            widget.textEditingController.clear();
          }, icon: const Icon(Icons.clear)):null,
        ),
      )
    ;
  }
}

class PasswordTextForm extends StatefulWidget {
 final String text;
  final TextEditingController passwordEditingController= TextEditingController();

  PasswordTextForm({Key? key,required this.text}) : super(key: key);

  @override
  _PasswordTextFormState createState() => _PasswordTextFormState();
}

class _PasswordTextFormState extends State<PasswordTextForm> {
  var _passwordVisible = false;
  @override
  void initState(){
    _passwordVisible=false;
    widget.passwordEditingController.addListener(() { });
    super.initState();
  }


  String? _validatorPassWord(value){
    if(value == null || value.isEmpty){
      return 'password can not be empty';
    }
    return null;
  }
  void _changePasswordVisible(){
    setState(() {
      _passwordVisible=!_passwordVisible;
    });

  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordEditingController,
      obscureText: !_passwordVisible,
      validator: _validatorPassWord,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all( Radius.circular(8)),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2
              )
          ),
          labelText: widget.text,
          hintText: widget.text,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon((_passwordVisible)?Icons.visibility: Icons.visibility_off),
              onPressed: _changePasswordVisible
          )
      ),
    );
  }
}
