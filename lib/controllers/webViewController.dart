
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';

class webViewController{
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // Track article reading
  void trackArticleRead(DateTime OPEN, DateTime CLOSE, String ARTICLE)async {
    int seconds = CLOSE.difference(OPEN).inSeconds;
    Articletrackingmodel articletrackingmodel = Articletrackingmodel(uid: auth.currentUser!.uid, articleKey: ARTICLE, timeStamp: CLOSE);

    // Between 2 and 4 minutes
    if (seconds >= 120 && seconds < 240){
      runReadTransaction(articletrackingmodel, "2mins");
    }
    // Between 4 and 6 minutes
    else if(seconds >= 240 && seconds < 360){
      runReadTransaction(articletrackingmodel, "4mins");
    }
    // Over 6 minutes
    else if(seconds >= 360){
      runReadTransaction(articletrackingmodel, "6mins");
    }
  }

  // Tracks users revisiting an article
  void trackArticleRevisit(DateTime OPEN, DateTime CLOSE, String ARTICLE)async {
    int seconds = CLOSE.difference(OPEN).inSeconds;
    Articletrackingmodel articletrackingmodel = Articletrackingmodel(uid: auth.currentUser!.uid, articleKey: ARTICLE, timeStamp: CLOSE);

    if (seconds >= 120 && seconds < 240){
      runTransactions(articletrackingmodel, "2mins", "revisits");
    }
    else if(seconds >= 240 && seconds < 360){
      runTransactions(articletrackingmodel, "4mins", "revisits");
    }
    else if(seconds >= 360){
      runTransactions(articletrackingmodel, "6mins", "revisits");
    }
 }

//Funtion for reading an article the first time
 void runReadTransaction(Articletrackingmodel MODEL, String time){
  final sfDocRef =  db.collection("articles").doc("pregnancyInfo").collection("docs").doc(MODEL.articleKey).
    collection("read").doc("total");

    db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(MODEL.articleKey).collection("read").doc(time).collection("reads").add(MODEL.toJson());

    db.collection("users").doc(auth.currentUser!.uid).collection("articleStats").doc(MODEL.articleKey).set({"name": MODEL.articleKey});

    db.collection("users").doc(auth.currentUser!.uid).collection("articleStats").doc(MODEL.articleKey).collection("read").doc("read")
    .set(MODEL.toJson());

    db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final reads = sfDoc.get("reads") + 1;
        transaction.update(sfDocRef, {"total": total, "reads" : reads});
      });
    });
  }

//Function for subsequent revisits to an article 
  void runTransactions(Articletrackingmodel MODEL, String time, String type){
    final sfDocRef =  db.collection("articles").doc("pregnancyInfo").collection("docs").doc(MODEL.articleKey).
    collection("read").doc("total");

    db.collection("articles").doc("pregnancyInfo").collection("docs")
    .doc(MODEL.articleKey).collection("read").doc(time).collection(type).add(MODEL.toJson());

    db.collection("users").doc(auth.currentUser!.uid).collection("articleStats").doc(MODEL.articleKey).collection(type)
    .add(MODEL.toJson());

    db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final total = sfDoc.get("total") + 1;
        final revisits = sfDoc.get(type) + 1;
        transaction.update(sfDocRef, {"total": total, type : revisits});
      });
    });
  }

  // Checks if users are revisiting or first time reading
  void checkIfRevisit(DateTime OPEN, DateTime CLOSE, String ARTICLE)async{
    try {
        await db.collection("users").doc(auth.currentUser!.uid).collection("articleStats").doc(ARTICLE).collection("read").doc("read").get().then((doc) {
            if(doc.exists){
              trackArticleRevisit(OPEN, CLOSE, ARTICLE);
            }
            else{trackArticleRead(OPEN, CLOSE, ARTICLE);}
        });
    } catch (e) {
        // If any error
    }
    }
  }