import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/AppConfig.dart';


class Homepagecontroller {
  var preferences = AppConfig();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

}