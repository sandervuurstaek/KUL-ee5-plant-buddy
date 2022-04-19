
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widgets/imageWidget.dart';
import '../widgets/specialButton.dart';
import '../widgets/transparant_appbar.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
    const RegisterPage({Key? key}) : super(key: key);

    @override
    _RegisterPageState createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool loading=false;

    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController emailEditingController= TextEditingController();
    final TextEditingController passwordEditingController= TextEditingController();
    final TextEditingController confirmPasswordController=TextEditingController();


    var _isShowClear = false;
    var _isfirstnameClear= false;
    var _islastnameClear=false;
    var _passwordVisible = false;
    var _confirmpasswordVisible = false;

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
      firstnameController.addListener(() {
        if(firstnameController.text.isNotEmpty){
          _isfirstnameClear = true;
        }
        else{
          _isfirstnameClear =false;
        }
        setState(() {
        });
      });
      lastnameController.addListener(() {
        if(lastnameController.text.isNotEmpty){
          _islastnameClear = true;
        }
        else{
          _islastnameClear =false;
        }
        setState(() {
        });
      });

      _passwordVisible=false;
      passwordEditingController.addListener(() { });
      confirmPasswordController.addListener(() { });

      super.initState();
    }
    @override
    void dispose(){
      emailEditingController.dispose();
      passwordEditingController.dispose();
      super.dispose();
    }
    void changePasswordVisible(){
      _passwordVisible=!_passwordVisible;
    }

    void changeConfirmPasswordVisible(){
      _confirmpasswordVisible=!_confirmpasswordVisible;
    }

    String? _validatorFirstname(value){
      if(value == null || value.isEmpty){
        return 'Firstname can not be empty';
      }
      return null;
    }
    String? _validatorLastname(value){
      if(value == null || value.isEmpty){
        return 'Lastname can not be empty';
      }
      return null;
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

    String? _validatorconfirmPassWord(value){
      if(value == null || value.isEmpty){
        return 'Please confirm your password';
      }
      return null;
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
                validator: _validatorFirstname,
                controller: firstnameController,
                decoration: InputDecoration(
                  border:  const OutlineInputBorder(
                      borderRadius: BorderRadius.all( Radius.circular(8)),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2
                      )
                  ),
                  labelText: "Firstname",
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: (_isfirstnameClear)? IconButton(onPressed: (){
                   firstnameController.clear();
                  }, icon: const Icon(Icons.clear)):null,
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: _validatorLastname,
                controller: lastnameController,
                decoration: InputDecoration(
                  border:  const OutlineInputBorder(
                      borderRadius: BorderRadius.all( Radius.circular(8)),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2
                      )
                  ),
                  labelText: "Lastname",
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: (_islastnameClear)? IconButton(onPressed: (){
                    lastnameController.clear();
                  }, icon: const Icon(Icons.clear)):null,
                ),
              ),
              const SizedBox(height: 10),
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
                          setState(changePasswordVisible);
                        }
                    )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _confirmpasswordVisible,
                validator: _validatorconfirmPassWord,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all( Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2
                        )
                    ),
                    labelText: "Confirm password",
                    hintText: "Please confirm your password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon((_confirmpasswordVisible)?Icons.visibility: Icons.visibility_off),
                        onPressed: (){
                          setState(changeConfirmPasswordVisible);
                        }
                    )
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      );

      //loginTextForm
    /*  Widget inputTextArea = Container(
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
              //UserNameTextFormField(),
              SizedBox(height: 10),
              //PassWordTextFormField(),
              SizedBox(height: 10),
              //PassWordTextFormField(),
              SizedBox(height: 32),
            ],
          ),
        ),
      );*/

      void _tryRegister() async {
        if(_formKey.currentState!.validate())
        {
          print(firstnameController.text);
          print(lastnameController.text);
          print(emailEditingController.text);
          print(passwordEditingController.text);
          print(confirmPasswordController.text);
          if(passwordEditingController.text==confirmPasswordController.text)
            {
              int code= await User().UserRegister(firstnameController.text,lastnameController.text, emailEditingController.text, passwordEditingController.text);
              if(code==200)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Home();
                }));
              }
            }

        }
      }

      //login Button
      Widget loginButtonArea =  Container(
          margin:  const EdgeInsets.only(left: 20,right: 20),
          child: RoundedButton(data: "register", pressed: _tryRegister));


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
