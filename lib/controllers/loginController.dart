import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Logincontroller {
final auth = FirebaseAuth.instance;

Future signInUser(String e, String p) async{
  try{
    await auth.signInWithEmailAndPassword(email: e, password: p);
    log("Success");
  }
  catch(e){}
}

}