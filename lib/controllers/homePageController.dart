import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/models/AppConfig.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/views/adminHomeView.dart';

class Homepagecontroller {
  var preferences = AppConfig();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  void getRole() async{
    userModel u = await db.collection("users").doc(auth.currentUser!.uid).get().then((value) {
      return userModel.fromJson(value.data());
    });
    if(u.role == "user"){}
    else{Get.to(Adminhomeview());}
  }
}