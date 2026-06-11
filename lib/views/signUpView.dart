import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/signUpController.dart';

class Signupview extends StatelessWidget{
  final _email = TextEditingController();
  final _password = TextEditingController();
  final control = signUpController();

  Signupview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center( 
        child:Padding(padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
            const SizedBox(height: 50,),
            TextField(controller: _email,),
            const SizedBox(height: 50,),
            TextField(controller: _password,),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed:() => signup(), child: Text("SignUp"))
          ],
        )
      )
    )
  );
}

  void signup(){
    control.createUser(_email.text, _password.text);
  }
  
}