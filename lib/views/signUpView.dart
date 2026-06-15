import 'dart:math';

import 'package:birth_picker/birth_picker.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/signUpController.dart';

class Signupview extends StatelessWidget{
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _postcode = TextEditingController();
  final _hospital = TextEditingController();
  DateTime? _age;
  final _lang = TextEditingController();
  final _bioSex = TextEditingController();
  final _dueDate = TextEditingController();
  final _reistrationDate = TextEditingController();
  final _discover = TextEditingController();
  final _classes = TextEditingController();
  final control = signUpController();

  Signupview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center( 
        child:Padding(padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
            /* Email */
            const SizedBox(height: 50,),
            TextField(controller: _email,
            decoration: InputDecoration(labelText: "Email"),style: TextStyle(fontSize: 20),),
            /* Password */
            const SizedBox(height: 50,),
            TextField(controller: _password,
            decoration: InputDecoration(labelText: "Password"),style: TextStyle(fontSize: 20),),
            /* Name */
            const SizedBox(height: 50,),
            TextField(controller: _name,
            decoration: InputDecoration(labelText: "Full Name"),style: TextStyle(fontSize: 20),),
            const SizedBox(height: 50,),
            /* Age */
            Text("Date Of Birth"),
            BirthPicker(
              decorationBuilder: (bool isFocused) {
                return BoxDecoration(
                  border: Border.all(
                    color: isFocused ? Colors.blue : Colors.grey,
                    width: isFocused ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                );
              },
              onChanged: (DateTime? dateTime) {
                _age = dateTime;
              },
            ),
            /* SignUp Button */
            const SizedBox(height: 30,),
            ElevatedButton(onPressed:() => signup(), child: Text("SignUp"))
          ],
        )
      )
    )
  )
  );
}

  void signup(){
    control.createUser(_name.text, _email.text, _password.text, "BBB", "Good", DateTime.now(), "en", "M", DateTime.now(), DateTime.now(), "Option 1", "No");
  }
  
}