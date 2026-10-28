import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/pdfCreatorController.dart';

class Pdfcreatorview extends StatefulWidget{
    const Pdfcreatorview({super.key});


  @override
  _Pdfcreatorview createState() => _Pdfcreatorview();
}

class _Pdfcreatorview extends State<Pdfcreatorview>{
  final controller = Pdfcreatorcontroller();
  final _title = TextEditingController();
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: 
    Center(
      child: Column(
        children:[
          Text("NAME"),
          TextField(controller: _title),
          Text("INFORMATION"),
          TextField(controller: _text,),
          ElevatedButton(onPressed: (){controller.createPdf(_title.text, _text.text);}, child: Text("Button"))]
      ) )
    );
  }
}