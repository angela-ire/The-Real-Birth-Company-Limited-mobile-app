import 'package:cloud_firestore/cloud_firestore.dart';

class Appointmentmodel {
  DateTime date;
  String name;

  Appointmentmodel({required this.date, required this.name});

  static Appointmentmodel fromJson(Map<String, dynamic> json) => 
  Appointmentmodel(date: json['date'].toDate(), name: json['name']);

  Map<String, dynamic> toJson() =>{
  'date' : Timestamp.fromDate(date),
  'name' : name
  };
}