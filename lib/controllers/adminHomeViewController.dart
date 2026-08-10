
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Adminhomeviewcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> fetchUsers(){
    return db.collection("users").where('role', isEqualTo:  "user").snapshots();
  }
}