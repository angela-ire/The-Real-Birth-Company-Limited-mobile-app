import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Pdfcreatorcontroller {
  final pdf = pw.Document();
  
  Future<String> createFolder(String cow) async {
    final dir = Directory('${(Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
      )!
        .path}/$cow');
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  Future<void> createPdf(String title, String text) async {
    final netImage = await networkImage('https://realbirthcompany.com/wp-content/uploads/2025/09/200-500mls-480x402.png');
    pdf.addPage(
      pw.Page(
        build: (context) {
        return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            title,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 50),

          pw.Row(children:
          [
            pw.Container(height: 250,width: 200, padding: pw.EdgeInsets.all(20), alignment: pw.Alignment.topLeft, 
            child: pw.Text(text, maxLines: 99, style: pw.TextStyle(fontSize: 20))), 
            pw.Align(alignment: pw.Alignment.centerRight,
            child: pw.Image(netImage, width: 250, height: 250,)),
          ])

        ],
      );
      },),
    );

    final bytes = await pdf.save();
    String path = await createFolder("RBC_APP");
    print(path);
    final file = File("${path}/${title}.pdf");
    await file.writeAsBytes(bytes);
    listPDF();
  }

  void listPDF() async{
    final dir = Directory('${(Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
      )!
        .path}/RBC_APP');
    List<FileSystemEntity> _files;
    _files = dir.listSync(recursive: true, followLinks: false);
    print(_files.length);
  }

}