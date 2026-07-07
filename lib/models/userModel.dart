import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {

  String uid;
  String name;
  String email;
  String postcode;
  String hospital;
  DateTime dateOfBirth;
  String lang;
  String bioSex;
  DateTime dueDate;
  DateTime registrationDate;
  String discover;
  String classes;
  String role;

  userModel({required this.uid, required this.name, required this.email, required this.postcode, required this.hospital,
  required this.dateOfBirth, required this.lang, required this.bioSex, required this.dueDate, required this.registrationDate,
  required this.discover, required this.classes, required this.role}){}

  static userModel fromJson(Map<String, dynamic>? json) => 
  userModel(uid: json?['uid'], name: json?['name'], email: json?['email'], 
  classes: json?['classes'], postcode: json?['postcode'], hospital: json?['hospital'], 
  dateOfBirth: json?['dateOfBirth'].toDate() , lang: json?['lang'], bioSex: json?['bioSex'], 
  dueDate: json?['dueDate'].toDate(), registrationDate: json?['registrationDate'].toDate(), 
  discover: json?['discover'], role: json?['role']);
  

/* Converts the object into json data to be sent to Firebase */
  Map<String, dynamic> toJson() =>{
    'uid' : uid,
    'name' : name,
    'email' : email,
    'postcode' : postcode,
    'hospital' : hospital,
    'dateOfBirth' : Timestamp.fromDate(dateOfBirth!),
    'lang' : lang,
    'bioSex' : bioSex,
    'dueDate' : Timestamp.fromDate(dueDate!),
    'registrationDate' : Timestamp.fromDate(registrationDate!),
    'discover' : discover,
    'classes' : classes,
    'role' : role,
  };
}