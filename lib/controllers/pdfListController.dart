import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_birth_app/models/articleModel.dart';

class Pdflistcontroller {
  final FirebaseFirestore db = FirebaseFirestore.instance;

//Gets a list of all articles into a stream to be outputted
  Stream<List<Articlemodel>> fetchPdf(){
     return db.collection("pdfs")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Articlemodel.fromJson(doc.data()))
            .toList());
  }
}