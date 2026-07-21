import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/birthNotes.dart';

class Birthplannercontroller {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Birthnotes>> fetchNotes(String type){
    return db.collection("users").doc(auth.currentUser?.uid).collection("tools").doc("birthPlanner")
    .collection(type).snapshots()
    .map((snapshot) => snapshot.docs
            .map((doc) => Birthnotes.fromJson(doc.data()))
            .toList());
    }

  Future<void> addNote(String type, String text){
    Birthnotes note = Birthnotes(text: text, date: DateTime.now(), title: text);
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("birthPlanner")
    .collection(type).add(note.toJson());
  }
}