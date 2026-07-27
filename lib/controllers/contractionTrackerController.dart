import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:real_birth_app/models/contractionModel.dart';

class Contractiontrackercontroller extends GetxController{
  final timeELapsed = Stopwatch();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List<Contractionmodel>? pageModel;
  DateTime? stop;
  DateTime? start;
  RxString startStop = "Start".obs;

  void contractionSwitch(){
    //true
    if(timeELapsed.isRunning){
      timeELapsed.stop();
      stop = DateTime.now();
      startStop.value = "Start";
      contractionEnd((timeELapsed.elapsedMilliseconds / 1000), start!, stop!);
    }
    //false
    else{
      timeELapsed.reset();
      timeELapsed.start();
      start = DateTime.now();
      startStop.value = "Stop";
    }
  }

  void contractionEnd(double elapsed, DateTime start, DateTime end){
    elapsed = double.parse(elapsed.toStringAsFixed(2));
    Contractionmodel model = Contractionmodel(startTime: start, endTime: end, duration: elapsed);
    db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("contractionTracker")
    .collection("contractions").add(model.toJson());
  }

  Stream<List<Contractionmodel>> getContraction(){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("contractionTracker")
    .collection("contractions").orderBy("endTime", descending: true)
    .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Contractionmodel.fromJson(doc.data()))
            .toList());
  }
}