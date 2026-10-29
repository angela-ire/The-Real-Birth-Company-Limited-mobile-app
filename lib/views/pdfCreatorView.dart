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
  final _image = TextEditingController();
  final _today = TextEditingController();
  final _feeling = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: 
    Center(
      child: Column(
        children:[
          Text("Journal Entry Title"),
          TextField(controller: _title, maxLength: 25,),
          Text("Describe the image"),
          TextField(controller: _image, maxLength: 250,),
          Text("What I did Today"),
          TextField(controller: _today, maxLength: 300,),
          Text("How Do I Feel"),
          TextField(controller: _feeling, maxLength: 300,),
          ElevatedButton(onPressed: (){controller.createPdf(_title.text, _image.text, _today.text, _feeling.text);}, child: Text("Button"))]
      ) )
    );
  }
}