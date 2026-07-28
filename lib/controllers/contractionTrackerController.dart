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

  //Changes Stopwatch state and runs end contraction function
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

  //Runs when a contraction ends
  void contractionEnd(double elapsed, DateTime start, DateTime end){
    elapsed = double.parse(elapsed.toStringAsFixed(2));
    Contractionmodel model = Contractionmodel(startTime: start, endTime: end, duration: elapsed);
    db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("contractionTracker")
    .collection("contractions").add(model.toJson());
  }

  //Gets a list of all contractions for this user
  Stream<List<Contractionmodel>> getContraction(){
    return db.collection("users").doc(auth.currentUser!.uid).collection("tools").doc("contractionTracker")
    .collection("contractions").orderBy("endTime", descending: true)
    .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Contractionmodel.fromJson(doc.data()))
            .toList());
  }

  //Gets the average difference between contractions in the past hour
  double getFrequencyPastHour(List<Contractionmodel> listOfContractions){
    DateTime curr = DateTime.now();
    double total = 0;
    int count = 0;
    DateTime? lastEnd;
    for(int i = 0; i < listOfContractions.length; i++){
      if(curr.difference(listOfContractions[i].endTime).inHours < 1){
        if(lastEnd == null){
          lastEnd = listOfContractions[i].endTime;
        }
        else{
          total = total + lastEnd.difference(listOfContractions[i].startTime).inSeconds;
          lastEnd = listOfContractions[i].endTime;
        }
        count++;
      }
    }
    if(total == 0){
      return 0.0;
    }
    else{
      double avg = total / count;
      return avg;
    }
  }

  double getFrequency(List<Contractionmodel> listOfContractions){
    double total = 0;
    int count = 0;
    DateTime? lastEnd;
    for(int i = 0; i < listOfContractions.length; i++){
      if(lastEnd == null){
          lastEnd = listOfContractions[i].endTime;
        }
        else{
          total = total + lastEnd.difference(listOfContractions[i].startTime).inSeconds;
          lastEnd = listOfContractions[i].endTime;
        }
      count++;
    }
    if(total == 0){
      return 0.0;
    }
    else{
      double avg = total / count;
      return avg;
    }
  }

  double getAverage(List<Contractionmodel> listOfContractions){
    double total = 0.0;
    double avg = 0;
    for(int i = 0; i < listOfContractions.length; i++){
      total = total + listOfContractions[i].duration;
    }
    if(total == 0.0){
      avg = 0.0;
    }
    else{
      avg = total / listOfContractions.length;
    }
    return avg;
  }

  int getTotalOfHour(List<Contractionmodel> listOfContractions){
    final curr = DateTime.now();
    int total = 0;
    for(int i = 0; i < listOfContractions.length; i++){
      if(curr.difference(listOfContractions[i].endTime).inHours < 1){
        total++;
      }
    }
    return total;
  }

  //Takes a doube and converst as a standard minute format (mm:ss)
  String returnAsMinutes(double total){
    double mins = total / 60;
    double secs = total % 60;
    String? _secs;
    String? _mins;

    if(mins < 0){mins = 0;}
    
    if(secs < 10){
      _secs = "0${secs.truncate().toString()}";
    }
    else{
      _secs = secs.truncate().toString();
    }
    _mins = mins.truncate().toString();
    return "$_mins:$_secs"; 
    
  }
}