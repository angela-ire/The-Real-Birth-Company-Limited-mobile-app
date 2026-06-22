// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:real_birth_app/models/langModel.dart';
import 'package:real_birth_app/models/signUpPageText.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/models/userSignUpStats.dart';
import 'package:real_birth_app/views/homePageView.dart';

class signUpController {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late Usersignupstats userStats;

  late Signuppagetext pageText;

  /* Creates an open stream for language selection */
  Stream <List<Langmodel>> fetchLanguages(){
    return db.collection("resources")
    .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Langmodel.fromJson(doc.data()))
            .toList());
  }

  Future<Usersignupstats> fetchStats()async {
     return db.collection("stats").doc("userStats")
        .get()
        .then((value){
            return Usersignupstats.fromJson(value.data());
        });
  }

  void loadData() async{ 
    pageText = await fetchPage();
    userStats = await fetchStats();
  }

  Future<Signuppagetext> fetchPage()async {
    return db.collection("resources").doc("en").collection("pages").doc("signUpPage")
    .get()
    .then((value){
      return Signuppagetext.fromJson(value.data());
    });
  }

  /* Creates the document for the specific user */
  Future createUserDocument(userModel user) async{
    try{
      await db.collection("users").doc(user.uid).set(user.toJson());
      Get.to((Homepageview));
    }
    catch(e){}
  }

  /* Adds user to Auth table(account creation) */
  Future createUser(String name, String email, String password, String postcode, String hospital, DateTime dateOfBirth, String lang, String bioSex, DateTime dueDate, DateTime registrationDate, String discover, String classes) async{
    try{
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    final u = auth.currentUser;
    final uid = u!.uid;

      /* Adds user to Auth table(account creation) */
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

    createUserDocument(user);
    }
    catch(e){}
}

}