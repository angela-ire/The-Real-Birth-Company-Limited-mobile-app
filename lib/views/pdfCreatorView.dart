import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/pdfCreatorController.dart';
import 'package:image_picker/image_picker.dart';

class Pdfcreatorview extends StatefulWidget{
  const Pdfcreatorview({super.key});

  @override
  _Pdfcreatorview createState() => _Pdfcreatorview();
}

class _Pdfcreatorview extends State<Pdfcreatorview>{
  final ImagePicker _picker = ImagePicker();
  final controller = Pdfcreatorcontroller();
  final _title = TextEditingController();
  final _image = TextEditingController();
  final _today = TextEditingController();
  final _feeling = TextEditingController();
  XFile? image;
  File? _path;

  void getImage () async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      _path = File(image!.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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

            ElevatedButton.icon(
              onPressed: () {getImage();},
              icon: const Icon(Icons.camera_alt),
              label: const Text('Choose Image'),
            ),

            ElevatedButton(onPressed: (){clearPhoto();}, child: Text("Clear Photo")),
            ElevatedButton(onPressed: (){imageOrNoImage();}, child: Text("Button")),

            SizedBox(height: 250, width: 250, child: _path == null 
            ? const Text("No Image Selected")
            :Image.file(_path!))
            
          ]
        )
      )
    );
  }

  void clearPhoto(){
    if(image != null){
      image = null;
      _path = null;
      setState(() {});
    }
  }

  void imageOrNoImage(){
    if(image != null){
      controller.createPdf(_title.text, _image.text, _today.text, _feeling.text, image!);
    }
    else{
      controller.createPdfNoImage(_title.text, _today.text, _feeling.text);
    }
  }
}