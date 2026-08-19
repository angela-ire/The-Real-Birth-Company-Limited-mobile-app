
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';

class Pdfviewcontroller{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  //Tracks users reading articles
  void trackArticleRead(DateTime OPEN, DateTime CLOSE, String ARTICLE)async {
    int seconds = CLOSE.difference(OPEN).inSeconds;
    Articletrackingmodel articletrackingmodel = Articletrackingmodel(uid: auth.currentUser!.uid, articleKey: ARTICLE, timeStamp: CLOSE);

    final sfDocRef =  db.collection("pdfs").doc(ARTICLE).collection("read").doc("total");

    //if users used for between 2 and 4 minutes
    if (seconds >= 120 && seconds < 240){
      db.collection("pdfs")
      .doc(ARTICLE).collection("read").doc("2mins").collection("reads").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("read").doc("read")
      .set(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final reads = sfDoc.get("reads") + 1;
        transaction.update(sfDocRef, {"total": total, "reads" : reads});
      });
      });
    }

    //if users used between 4 and 6 minutes
    else if(seconds >= 240 && seconds < 360){
      db.collection("pdfs")
      .doc(ARTICLE).collection("read").doc("4mins").collection("reads").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("read").doc("read")
      .set(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final reads = sfDoc.get("reads") + 1;
        transaction.update(sfDocRef, {"total": total, "reads" : reads});
      });
      });
    }

    // 6 minutes plus
    else if(seconds >= 360){
      db.collection("pdfs")
      .doc(ARTICLE).collection("read").doc("6mins").collection("reads").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("read").doc("read")
      .set(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final reads = sfDoc.get("reads") + 1;
        transaction.update(sfDocRef, {"total": total, "reads" : reads});
      });
      });
    }
  }

  //Same as above but tracks if a user is revisiting an article instead of a fresh read
  void trackArticleRevisit(DateTime OPEN, DateTime CLOSE, String ARTICLE)async {
    int seconds = CLOSE.difference(OPEN).inSeconds;
    Articletrackingmodel articletrackingmodel = Articletrackingmodel(uid: auth.currentUser!.uid, articleKey: ARTICLE, timeStamp: CLOSE);


    final sfDocRef =  db.collection("pdfs").doc(ARTICLE).
    collection("read").doc("total");

    if (seconds >= 120 && seconds < 240){
      db.collection("pdfs")
      .doc(ARTICLE).collection("read").doc("2mins").collection("revisits").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("revisits")
      .add(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final revisits = sfDoc.get("revisits") + 1;
        transaction.update(sfDocRef, {"total": total, "revisits" : revisits});
      });
      });
    }
    else if(seconds >= 240 && seconds < 360){
      db.collection("pdfs")
      .doc(ARTICLE).collection("read").doc("4mins").collection("revisits").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("revisits")
      .add(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final revisits = sfDoc.get("revisits") + 1;
        transaction.update(sfDocRef, {"total": total, "revisits" : revisits});
      });
      });
    }
    else if(seconds >= 360){
      db.collection("articles")
      .doc(ARTICLE).collection("read").doc("6mins").collection("revisits").add(articletrackingmodel.toJson());

      db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("revisits")
      .add(articletrackingmodel.toJson());

      db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final revisits = sfDoc.get("revisits") + 1;
        transaction.update(sfDocRef, {"total": total, "revisits" : revisits});
      });
      });
    }
 }

  void pdfRead(Articletrackingmodel MODEL, String time){
    final sfDocRef =  db.collection("pdfs").doc(MODEL.articleKey).
    collection("read").doc("total");

    db.collection("pdfs")
    .doc(MODEL.articleKey).collection("read").doc("time").collection("reads").add(MODEL.toJson());

    db.collection("users").doc(auth.currentUser!.uid).collection("pdftats").doc(MODEL.articleKey).set({"name": MODEL.articleKey});

    db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(MODEL.articleKey).collection("read").doc("read")
    .set(MODEL.toJson());

    db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final reads = sfDoc.get("reads") + 1;
        transaction.update(sfDocRef, {"total": total, "reads" : reads});
      });
    });
  }

  void pdfRevisit(Articletrackingmodel MODEL, String time){
    final sfDocRef =  db.collection("pdfs").doc(MODEL.articleKey).
    collection("read").doc("total");

    db.collection("articles")
    .doc(MODEL.articleKey).collection("read").doc(time).collection("revisits").add(MODEL.toJson());

    db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(MODEL.articleKey).collection("revisits")
    .add(MODEL.toJson());

    db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final revisits = sfDoc.get("revisits") + 1;
        transaction.update(sfDocRef, {"total": total, "revisits" : revisits});
      });
    });
  }

  //Checks if user is revisiting or not
  void checkIfRevisit(DateTime OPEN, DateTime CLOSE, String ARTICLE)async{
    try {
        await db.collection("users").doc(auth.currentUser!.uid).collection("pdfStats").doc(ARTICLE).collection("read").doc("read").get().then((doc) {
            if(doc.exists){
              trackArticleRevisit(OPEN, CLOSE, ARTICLE);
            }
            else{trackArticleRead(OPEN, CLOSE, ARTICLE);}
            ;
        });
    } catch (e) {
        // If any error
    }
    }
  }