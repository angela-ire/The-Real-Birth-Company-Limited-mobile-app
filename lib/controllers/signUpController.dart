// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:real_birth_app/models/AppConfig.dart';
import 'package:real_birth_app/models/langModel.dart';
import 'package:real_birth_app/models/signUpPageText.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/models/userSignUpStats.dart';
import 'package:real_birth_app/views/homePageView.dart';

class signUpController {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late Usersignupstats userStats;
  var preferences = AppConfig();

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

  Future<Signuppagetext> fetchPage()async {
    return db.collection("resources").doc(preferences.langKey).collection("pages").doc("signUpPage")
    .get()
    .then((value){
      return Signuppagetext.fromJson(value.data());
    });
  }

  /* Create new user stats records */
  Future createUserStats(userModel user) async{
    userStats = await fetchStats();
    userStats.totalUsers = userStats.totalUsers! + 1;

    /* Finds user age and sperates by bracket */
    int ageInDays = DateTime.now().difference(user.dateOfBirth).inDays;
    if(ageInDays < 6575){
      userStats.underEighteen = userStats.underEighteen! + 1;
    } 
    else if(ageInDays >= 6575 && ageInDays < 9132){
      userStats.eighteenTwentyFive = userStats.eighteenTwentyFive! + 1;
    }
    else{
      userStats.twentyFivePlus = userStats.twentyFivePlus! + 1;
    }

    /*Checks how user found app*/
    if(user.discover == "Option 1"){
      userStats.discoveryOption1 = userStats.discoveryOption1! + 1;
    }
    else{
      userStats.discoveryOption2 = userStats.discoveryOption2! + 1;
    }

  /*Checks if user takes classes*/
    if(user.classes == "Yes"){
      userStats.classes = userStats.classes! + 1;
     }

  /*Find user Gender*/
    if(user.bioSex == "F"){
      userStats.female = userStats.female! + 1;
    }
    else{
      userStats.male = userStats.male! + 1;
    }

    /*Checks user language*/
    if(user.lang == "en"){
      userStats.en = userStats.en! + 1;
    }
    else if(user.lang == "ar"){
      userStats.ar = userStats.ar! + 1;
    }

    db.collection("stats").doc("userStats").update(userStats.toJson());
  }

  /* Creates the document for the specific user */
  Future createUserDocument(userModel user) async{
    try{
      await db.collection("users").doc(user.uid).set(user.toJson());
      createUserStats(user);
      Get.to(Homepageview());
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
      userModel user = userModel(uid: uid, name: name, email: email, postcode: postcode, 
      hospital: hospital, dateOfBirth: dateOfBirth, lang: lang, bioSex: bioSex, 
      dueDate: dueDate, registrationDate: registrationDate, discover: discover, classes: classes);

    createUserDocument(user);
    }
    catch(e){}
}

}