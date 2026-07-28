import 'package:cloud_firestore/cloud_firestore.dart';

class Appointmentmodel {
  DateTime date;

  Appointmentmodel({required this.date}){}

  static Appointmentmodel fromJson(Map<String, dynamic> json) => 
  Appointmentmodel(date: json['date'].toDate());

  Map<String, dynamic> toJson() =>{
  'date' : Timestamp.fromDate(date),
  };
}