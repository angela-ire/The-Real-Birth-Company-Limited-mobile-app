import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/birthNotes.dart';

class Birthplannercontroller {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> fetchNotes(String type){
    return db.collection("users").doc(auth.currentUser?.uid).collection("tools").doc("birthPlanner")
    .collection(type).orderBy("date", descending: true).snapshots();
    }

  Future<void> addNote(String type, String text, String? docId){
    Birthnotes note = Birthnotes(text: text, date: DateTime.now(), title: text);
    if(docId == null){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("birthPlanner")
    .collection(type).add(note.toJson());
    }
    else{

      return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("birthPlanner")
      .collection(type).doc(docId).update({"text": text});
    }
  }

  Future<void> deleteNote(String type, String docId){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("birthPlanner")
    .collection(type).doc(docId).delete();
  }
}