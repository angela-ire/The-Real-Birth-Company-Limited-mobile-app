
import 'package:cloud_firestore/cloud_firestore.dart';

class Articletrackingmodel {
  String uid = "";
  String articleKey ="";
  DateTime? timeStamp;

  Map<String, dynamic> toJson() =>{
    'uid' : uid,
    'articleKey' : articleKey,
    'timeStamp' : Timestamp.fromDate(timeStamp!),
  };

}