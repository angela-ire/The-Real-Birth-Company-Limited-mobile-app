import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/adminUserController.dart';
import 'package:real_birth_app/models/userModel.dart';

class Adminuserview extends StatefulWidget{
  final userModel link;
  const Adminuserview({super.key, required this.link});

  @override
  State<Adminuserview> createState() => _Adminuserview();
}

class _Adminuserview extends State<Adminuserview>{
  final controller = Adminusercontroller();

  @override
  void initState(){
    super.initState();
    final currUser = widget.link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(child: ElevatedButton(onPressed: (){controller.getUserArticleStats("iKECUNKfC6hhfJc2CLqTZUaomJv1");}, child: Text("data")),
    ));
  }
}