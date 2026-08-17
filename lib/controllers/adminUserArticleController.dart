import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';

class Adminuserarticlecontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

Future<List<Articletrackingmodel>> getAll(String uid, String article) async{
    List<Articletrackingmodel> currRevis = await db.collection("users").doc(uid)
    .collection("articleStats").doc(article).collection("revisits").get()
    .then(((value) {
      List<Articletrackingmodel> l =[];
      l = value.docs.map((data) => Articletrackingmodel.fromJson(data.data())).toList();
      return l;
    }));
    List<Articletrackingmodel> currRead = await db.collection("users").doc(uid)
    .collection("articleStats").doc(article).collection("read").get()
    .then(((value) {
      List<Articletrackingmodel> l =[];
      l = value.docs.map((data) => Articletrackingmodel.fromJson(data.data())).toList();
      return l;
    }));
    List<Articletrackingmodel> currArts = currRevis;
    currArts.add(currRead[0]);
    return currArts;
  }
}