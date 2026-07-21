import 'package:cloud_firestore/cloud_firestore.dart';

class Birthnotes {

  String text;
  DateTime date;
  String title;

  Birthnotes({required this.text, required this.date, required this.title}){}

  static Birthnotes fromJson(Map<String, dynamic> json) => 
  Birthnotes(text: json['text'], date: json['date'].toDate(), title: json['title']);

    Map<String, dynamic> toJson() =>{
    'text' : text,
    'date' : Timestamp.fromDate(date),
    'title' : title,
    };
}