import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';
import 'package:real_birth_app/models/totalArticleModel.dart';

class Adminarticlestatscontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<List<Articletrackingmodel>> getAllStats(String article) async{
    List<Articletrackingmodel> allReads = await getReads(article, "reads");
    List<Articletrackingmodel> allRevisits = await getReads(article, "revisits");

    for(int i = 0; i < allReads.length; i++){
      allRevisits.add(allReads[i]);
    }
    return allRevisits;
  }

  Future<Totalarticlemodel> getNumberTotal(String article) async{
    Totalarticlemodel model = await db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(article).collection("read").doc("total").get().then((value) {
      return Totalarticlemodel.fromJson(value.data());
    
    });
    return model;
  }

  Future<List<Articletrackingmodel>> getReads(String article, String type) async{
    List<Articletrackingmodel> twoMinsRead = await db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(article).collection("read").doc("2mins").collection(type).get()
    .then(((value) {
      return value.docs.map((data) => Articletrackingmodel.fromJson(data.data())).toList();
    }));

    List<Articletrackingmodel> fourMinsRead = await db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(article).collection("read").doc("4mins").collection(type).get()
    .then(((value) {
      return value.docs.map((data) => Articletrackingmodel.fromJson(data.data())).toList();
    }));

    List<Articletrackingmodel> sixMinsRead = await db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(article).collection("read").doc("6mins").collection(type).get()
    .then(((value) {
      return value.docs.map((data) => Articletrackingmodel.fromJson(data.data())).toList();
    }));
    List<Articletrackingmodel> totalRead = [];

    for(int i = 0; i < twoMinsRead.length; i++){
      totalRead.add(twoMinsRead[i]);
    }
    for(int i = 0; i < fourMinsRead.length; i++){
      totalRead.add(fourMinsRead[i]);
    }
    for(int i = 0; i < sixMinsRead.length; i++){
      totalRead.add(sixMinsRead[i]);
    }
    return totalRead;
  }
}
