
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/preLoginController.dart';

class Preloginview extends StatefulWidget{
  const Preloginview ({super.key});
  @override
  State<Preloginview> createState() => _Preloginview();
}

class _Preloginview extends State<Preloginview>{
  Prelogincontroller control = Prelogincontroller();
  @override
  void initState() {
    super.initState();
    control.getRole();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}