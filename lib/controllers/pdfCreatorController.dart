import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Pdfcreatorcontroller {
  final pdf = pw.Document();
  
  Future<void> createPdf() async {
    pdf.addPage(
      pw.Page(
        build: (context) {
        return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [

          pw.Text(
            'Expense Report',
            style: pw.TextStyle(
              fontSize: 26,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Text('Name: Ankit'),

          pw.Text('Month: July'),

          pw.Text('Total Expense: ₹18,450'),

          pw.SizedBox(height: 20),

          pw.Divider(),

          pw.Text(
            'Generated using Flutter',
            style: pw.TextStyle(
              color: PdfColors.grey,
            ),
          ),
        ],
      );
      },),
    );
    final output = await getDownloadsDirectory();
    final bytes = await pdf.save();
    final file = File("${"/storage/emulated/0/Download"}/example.pdf");
    await file.writeAsBytes(bytes);
    print(output!.path);
  }
}