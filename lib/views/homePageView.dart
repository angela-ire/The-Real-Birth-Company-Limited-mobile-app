import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/homePageController.dart';

class Homepageview extends StatelessWidget{
  final control = Homepagecontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(control.preferences.langKey),
      
    );
  }
}