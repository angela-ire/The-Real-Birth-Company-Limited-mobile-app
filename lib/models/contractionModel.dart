import 'package:cloud_firestore/cloud_firestore.dart';

class Contractionmodel {
  DateTime startTime;
  DateTime endTime;
  double duration;

  Contractionmodel({required this.startTime, required this.endTime, required this.duration});

  static Contractionmodel fromJson(Map<String, dynamic> json) => 
   Contractionmodel(startTime: json['startTime'].toDate(), endTime: json['endTime'].toDate(), duration: json['duration']);

    Map<String, dynamic> toJson() =>{
    'startTime' : Timestamp.fromDate(startTime),
    'endTime' : Timestamp.fromDate(endTime),
    'duration' : duration
    };
}