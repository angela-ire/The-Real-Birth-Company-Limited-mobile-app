import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/bagItemModel.dart';

class Bagchecklistcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> fetchBagItem(){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").snapshots();
  }

  Future<void> addBagItem(String item, String? docId){
    final bagItem = Bagitemmodel(item: item, checked: false);
    if(docId == null){
      return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
      .doc("bagChecklist").collection("items").add(bagItem.toJson());
    }
    else{
      return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
      .doc("bagChecklist").collection("items").doc(docId).update({"item": item});
    }
  }

  Future<void> checkItem(bool change, String docId){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").doc(docId).update({"checked": change});
  }

  Future<void> deleteItem(docId){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").doc(docId).delete();
  }
}