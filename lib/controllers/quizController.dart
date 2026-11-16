import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/quizModel.dart';

class Quizcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<quizModel> fetchQuiz(String docName, String num) async{
    return db.collection("resources").doc("quiz").collection(docName)
    .doc(num).get()
    .then((value){
      return quizModel.fromJson(value.data());
    });
  }

  Stream<List<quizModel>> fetchQuizs(String docName){
    return db.collection("resources").doc("quiz").collection(docName)
    .snapshots().map((snapshot) => snapshot.docs
    .map((doc) => quizModel.fromJson(doc.data()))
    .toList());
    }

}