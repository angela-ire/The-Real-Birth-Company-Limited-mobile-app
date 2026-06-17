import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {

  String? uid;
  String? name;
  String? email;
  String? postcode;
  String? hospital;
  DateTime? dateOfBirth;
  String? lang;
  String? bioSex;
  DateTime? dueDate;
  DateTime? registrationDate;
  String? discover;
  String? classes;

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
    'classes' : classes
  };



}