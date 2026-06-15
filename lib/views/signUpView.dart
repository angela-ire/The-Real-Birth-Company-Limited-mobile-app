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
  DateTime? _dateOfBirth;
  final _lang = TextEditingController();
  final _bioSex = TextEditingController();
  DateTime? _dueDate;
  DateTime? _reistrationDate;
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
            
            /* Age */
            const SizedBox(height: 50,),
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
                _dateOfBirth = dateTime;
              },
            ),
            
            /* Postcode */
            const SizedBox(height: 50,),
            TextField(controller: _postcode,
            decoration: InputDecoration(labelText: "Postcode"),style: TextStyle(fontSize: 20),),
            
            /* Hospital */
            const SizedBox(height: 50,),
            TextField(controller: _hospital,
            decoration: InputDecoration(labelText: "Hospital"),style: TextStyle(fontSize: 20),),
            
            /* lang */
            const SizedBox(height: 50,),
            TextField(controller: _lang,
            decoration: InputDecoration(labelText: "lang"),style: TextStyle(fontSize: 20),),
            
            /* Bio Sex */
            const SizedBox(height: 50,),
            TextField(controller: _bioSex,
            decoration: InputDecoration(labelText: "Biological Sex"),style: TextStyle(fontSize: 20),),
            
            /*Due Date */
            const SizedBox(height: 50,),
            Text("Due Date"),
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
                _dueDate = dateTime;
              },
            ),
            
            /* FoundOut */
            const SizedBox(height: 50,),
            TextField(controller: _discover,
            decoration: InputDecoration(labelText: "How Did you Find Us"),style: TextStyle(fontSize: 20),),
            
            /* Classes */
            const SizedBox(height: 50,),
            TextField(controller: _classes,
            decoration: InputDecoration(labelText: "Do you go to any Classes"),style: TextStyle(fontSize: 20),),

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
    control.createUser(_name.text, _email.text, _password.text, _postcode.text, _hospital.text, _dateOfBirth!, _lang.text, _bioSex.text, _dueDate!, DateTime.now(), _discover.text, _classes.text);
  }
  
}