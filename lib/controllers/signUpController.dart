// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';

class signUpController {
  final auth = FirebaseAuth.instance;

  Future createUser(String e, String p) async{
    try{
    await auth.createUserWithEmailAndPassword(email: e, password: p);
    }
    catch(e){}
}

}