// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/controllers/loginController.dart';
import 'package:real_birth_app/views/signUpView.dart';

// ignore: use_key_in_widget_constructors
class Loginview extends StatelessWidget{
  final _email = TextEditingController();
  final _password = TextEditingController();
  final controller = Logincontroller();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center( 
        child:Padding(padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* email */
            const Text("Real Birth Company", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
            const SizedBox(height: 50,),
            TextField(controller: _email,),
            /* password */
            const SizedBox(height: 50,),
            TextField(controller: _password,),
            /* 2 buttons */
            const SizedBox(height: 30,),
            ElevatedButton(onPressed:() => login(), child: Text("Login")),
            ElevatedButton(onPressed: () => pageSwitch(), child: Text("Create Account"))
          ],
        )
      )
    )
  );
  }
    void login(){
      controller.signInUser(_email.text, _password.text);
  }

  void pageSwitch(){
    Get.to(Signupview());
  }
}