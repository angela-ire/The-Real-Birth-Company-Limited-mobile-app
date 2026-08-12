
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';

class Adminusercontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  

  Stream<List<Articletrackingmodel>> getIndividualArticle(String uid, String article){
    return db.collection("users").doc("articleStats")
    .collection("collectionPath").doc(article).collection("revisits")
    .snapshots()
    .map((snapshot) => snapshot.docs
    .map((doc) => Articletrackingmodel.fromJson(doc.data()))
    .toList());
  }
  
  Future<List<String>> getVisitedArticles(String uid) async{
    List<String> seenDocs = await db.collection("users").doc(uid)
    .collection("articleStats").get()
    .then((value) {
      List<String> l = [];
      for(int i = 0; i < value.docs.length; i++){;
        l.add(value.docs[i].id);
      }
      return l;
    });
    return seenDocs;
  }

}