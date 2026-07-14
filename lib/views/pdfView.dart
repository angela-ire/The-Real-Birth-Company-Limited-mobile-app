import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:real_birth_app/controllers/webViewController.dart';
import 'package:real_birth_app/models/articleModel.dart';

class Pdfview extends StatefulWidget {
  final Articlemodel link;
  const Pdfview({super.key, required this.link});

  @override
  State<Pdfview> createState() => _Pdfview();
}

class _Pdfview extends State<Pdfview> {
  final webViewController web = webViewController();
  late DateTime currTime;
  final initTime  = DateTime.now();
  
//Create log
  @override
  void dispose() {
    currTime = DateTime.now();
    web.checkIfRevisit(initTime, currTime, widget.link.key);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:  PdfViewer.uri(Uri.parse(widget.link.link)),
    ) ,
      );
  }
}
