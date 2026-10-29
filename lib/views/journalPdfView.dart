import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:real_birth_app/controllers/journalPdfController.dart';

class Journalpdfview extends StatefulWidget {
  const Journalpdfview({super.key});

  @override
  State<Journalpdfview> createState() => _Journalpdfview();
}

class _Journalpdfview extends State<Journalpdfview> {
  late DateTime currTime;
  final initTime  = DateTime.now();
  final controller = Journalpdfcontroller();
  late Future<String> FUTURE;

  @override
  void initState(){
    super.initState();
    FUTURE = controller.getFileLocation();
  }
  
//Create log
  @override
  void dispose() {
    currTime = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:  FutureBuilder(future: FUTURE , builder: ((context, snapshot) {
          if (snapshot.hasData){
            return PdfViewer.file('${snapshot.data!}/new3.pdf');
          }
          else{
            return Text("");
          }
        }
        )) 
      ) ,
    );
  }
}