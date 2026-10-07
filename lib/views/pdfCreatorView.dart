import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/pdfCreatorController.dart';

class Pdfcreatorview extends StatefulWidget{
    const Pdfcreatorview({super.key});


  @override
  _Pdfcreatorview createState() => _Pdfcreatorview();
}

class _Pdfcreatorview extends State<Pdfcreatorview>{
  final controller = Pdfcreatorcontroller();

  @override
  Widget build(BuildContext context){
    return Scaffold(body: Center(child: 
    ElevatedButton(onPressed: controller.createPdf, child: Text("data")),));
  }
}