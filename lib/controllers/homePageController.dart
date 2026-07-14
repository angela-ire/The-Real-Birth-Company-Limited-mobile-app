import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/AppConfig.dart';


class Homepagecontroller {
  var preferences = AppConfig();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void urlTrack()async{
    await db.collection("users").doc(auth.currentUser!.uid).collection("workshopStats").doc("workshopAccesses")
    .get().then((doc){
      if(doc.exists){
        final sfDocRef =  db.collection("users").doc(auth.currentUser!.uid).
        collection("workshopStats").doc("workshopAccesses");
        db.runTransaction((transaction){
        return transaction.get(sfDocRef).then((sfDoc) {
          final total = sfDoc.get("total") + 1;
          transaction.update(sfDocRef, {"total": total});
         });
        });
      }
      else{
        db.collection("users").doc(auth.currentUser!.uid).collection("workshopStats").doc("workshopAccesses")
        .set({"total": 1});
      }
    });

    final newDocRef = db.collection("stats").doc("workshopStats");
    db.runTransaction((transaction){
      return transaction.get(newDocRef).then((DocRef){
        final _total = DocRef.get("totalAccess") + 1;
        transaction.update(newDocRef, {"totalAccess": _total});
      });
    });
  }
}