
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleModel.dart';

class Adminhomeviewcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> fetchUsers(){
    return db.collection("users").where('role', isEqualTo:  "user").snapshots();
  }

    Future<List<Articlemodel>> getArticles() async {
    List<Articlemodel> MODELS = await db.collection("articles").doc("pregnancyInfo").collection("docs").get()
    .then(((value) {
      return value.docs.map((data) => Articlemodel.fromJson(data.data())).toList();
    }));
    return MODELS;
  }

}