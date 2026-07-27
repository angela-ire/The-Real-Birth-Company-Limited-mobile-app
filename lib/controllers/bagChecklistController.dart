import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/bagItemModel.dart';

class Bagchecklistcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  //Fetchs users bag items
  Stream<QuerySnapshot> fetchBagItem(){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").snapshots();
  }

  //Adds an item or if docId already exists updates old item
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

  //Item is checked or unchecked
  Future<void> checkItem(bool change, String docId){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").doc(docId).update({"checked": change});
  }

  //Delete item
  Future<void> deleteItem(docId){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools")
    .doc("bagChecklist").collection("items").doc(docId).delete();
  }
}