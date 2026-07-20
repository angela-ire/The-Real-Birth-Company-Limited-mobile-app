import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/birthNotes.dart';

class Birthplannercontroller {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Birthnotes>> fetchNotes(){
    return db.collection("users").doc(auth.currentUser?.uid).collection("tools").doc("birthPlanner")
    .collection("birthNotes").snapshots()
    .map((snapshot) => snapshot.docs
            .map((doc) => Birthnotes.fromJson(doc.data()))
            .toList());
    }

  Stream<List<Birthnotes>> fetchProcedures(){
    return db.collection("users").doc(auth.currentUser?.uid).collection("tools").doc("birthPlanner")
    .collection("birthProcedures").snapshots()
    .map((snapshot) => snapshot.docs
            .map((doc) => Birthnotes.fromJson(doc.data()))
            .toList());
  }

  Stream<List<Birthnotes>> fetchConditions(){
    return db.collection("users").doc(auth.currentUser?.uid).collection("tools").doc("birthPlanner")
    .collection("birthConditions").snapshots()
    .map((snapshot) => snapshot.docs
            .map((doc) => Birthnotes.fromJson(doc.data()))
            .toList());
  }
}