
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/views/adminHomeView.dart';
import 'package:real_birth_app/views/homePageView.dart';

class Prelogincontroller {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
//Checks user role and sends them to correct page
  void getRole() async{
    userModel u = await db.collection("users").doc(auth.currentUser!.uid).get().then((value) {
      return userModel.fromJson(value.data());
    });
    if(u.role == "user"){Get.to(Homepageview());}
    else if(u.role == "admin"){Get.to(Adminhomeview());}
  }
}