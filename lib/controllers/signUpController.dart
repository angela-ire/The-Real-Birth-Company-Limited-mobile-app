// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_birth_app/models/userModel.dart';

class signUpController {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future createUserDocument(String name, String uid, String email, String postcode, String hospital, DateTime dateOfBirth, String lang, String bioSex, DateTime dueDate, DateTime registrationDate, String discover, String classes) async{
    try{
      userModel user = userModel();
      user.name = name;
      user.email = email;
      user.postcode = postcode;
      user.hospital = hospital;
      user.dateOfBirth = dateOfBirth;
      user.lang = lang;
      user.bioSex = bioSex;
      user.dueDate = dueDate;
      user.registrationDate = registrationDate;
      user.discover = discover;
      user.classes = classes;
      user.uid = uid;
      await db.collection("users").doc(user.uid).set(user.toJson());
    }
    catch(e){}
  }

  Future createUser(String name, String email, String password, String postcode, String hospital, DateTime dateOfBirth, String lang, String bioSex, DateTime dueDate, DateTime registrationDate, String discover, String classes) async{
    try{
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    final u = auth.currentUser;
    final uid = u!.uid;
    createUserDocument(name, uid.toString(), email, postcode, hospital, dateOfBirth, lang, bioSex, dueDate, registrationDate, discover, classes);
    }
    catch(e){}
}

}