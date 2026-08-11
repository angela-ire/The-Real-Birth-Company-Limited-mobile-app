import 'package:cloud_firestore/cloud_firestore.dart';

class Articletrackingmodel {
  String uid = "";
  String articleKey ="";
  DateTime? timeStamp;

  Articletrackingmodel({required this.uid, required this.articleKey, required this.timeStamp});

  /* Converts Firebase Json into class object */
  static Articletrackingmodel fromJson(Map<String, dynamic> json) => Articletrackingmodel(uid: json['uid'], articleKey: json['articleKey'], timeStamp: json['timeStamp'].toDate());


  Map<String, dynamic> toJson() =>{
    'uid' : uid,
    'articleKey' : articleKey,
    'timeStamp' : Timestamp.fromDate(timeStamp!),
  };

}