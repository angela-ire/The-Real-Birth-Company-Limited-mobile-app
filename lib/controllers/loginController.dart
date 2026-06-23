import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/views/homePageView.dart';

class Logincontroller {
final auth = FirebaseAuth.instance;

/* Sign in */
Future signInUser(String e, String p) async{
  try{
    await auth.signInWithEmailAndPassword(email: e, password: p);
    Get.to(Homepageview());
  }
  catch(e){log("failed");}
}

}