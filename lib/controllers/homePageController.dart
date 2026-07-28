import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/AppConfig.dart';
import 'package:real_birth_app/models/userModel.dart';


class Homepagecontroller {
  var preferences = AppConfig();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  //Tracks if a user uses the workshop from the app
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

  //  Gets number of weeks until birth
  Future<int> getWeeks() async {
    DateTime curr = DateTime.now();
    userModel u = await db.collection("users").doc(auth.currentUser!.uid).get()
    .then((value){
      return userModel.fromJson(value.data());
    });
    int day = u.dueDate.difference(curr).inDays;
    return (day/7).truncate();
  }
}