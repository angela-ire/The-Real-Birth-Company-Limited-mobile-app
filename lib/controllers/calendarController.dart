import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/appointmentModel.dart';

class Calendarcontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<List<Appointmentmodel>> getDates(){
    return db.collection("users").doc(auth.currentUser!.uid).collection("calendar")
    .snapshots()
    .map((snapshot) => snapshot.docs
    .map((doc) => Appointmentmodel.fromJson(doc.data())).toList());
  }
  
 List<DateTime?> changeDate(List<DateTime?> dates,List<DateTime> date){
  if(dates.length > date.length){
    for(int i = 0; i < dates.length; i ++){
      if(!date.contains(dates[i])){
        db.collection("users").doc(auth.currentUser!.uid).collection("calendar")
        .doc(dates[i].toString()).delete();
      }
    }
  }
  else{
    for(int i = 0; i < date.length; i++){
      if(!dates.contains(date[i])){
        db.collection("users").doc(auth.currentUser!.uid).collection("calendar")
      .doc(date[i].toString()).set({"date": Timestamp.fromDate(date[i])});
      }
    }
  }
  return date;
 }
}