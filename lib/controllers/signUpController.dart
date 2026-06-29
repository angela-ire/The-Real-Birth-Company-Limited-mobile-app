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
  Usersignupstats userStats = Usersignupstats(totalUsers: 0, en: 0, ar: 0, classes: 0, underEighteen: 0, 
  eighteenTwentyFive: 0, twentyFivePlus: 0, discoveryOption1: 0, discoveryOption2: 0, female: 0, male: 0);
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
    userStats.totalUsers = 1;

    /* Finds user age and sperates by bracket */
    int ageInDays = DateTime.now().difference(user.dateOfBirth).inDays;
    if(ageInDays < 6575){
      userStats.underEighteen = 1;
    } 
    else if(ageInDays >= 6575 && ageInDays < 9132){
      userStats.eighteenTwentyFive = 1;
    }
    else{
      userStats.twentyFivePlus = 1;
    }

    /*Checks how user found app*/
    if(user.discover == "Option 1"){
      userStats.discoveryOption1 = 1;
    }
    else{
      userStats.discoveryOption2 = 1;
    }

  /*Checks if user takes classes*/
    if(user.classes == "Yes"){
      userStats.classes = 1;
     }

  /*Find user Gender*/
    if(user.bioSex == "F"){
      userStats.female = 1;
    }
    else{
      userStats.male = 1;
    }

    /*Checks user language*/
    if(user.lang == "en"){
      userStats.en = 1;
    }
    else if(user.lang == "ar"){
      userStats.ar = 1;
    }

    final sfDocRef =  db.collection("stats").doc("userStats");
    db.runTransaction((transaction){
      return transaction.get(sfDocRef).then((sfDoc) {
        final totalUsers = sfDoc.get("totalUsers") + 1;
        final classes = sfDoc.get("classes") + 1;
        final discoveryOption1 = sfDoc.get("discoveryOption1") + 1;
        final discoveryOption2 = sfDoc.get("discoveryOption2") + 1;
        final en = sfDoc.get("en") + 1;
        final ar = sfDoc.get("ar") + 1;
        final female = sfDoc.get("female") + 1;
        final male = sfDoc.get("male");
        final underEighteen = sfDoc.get("underEighteen") + 1;
        final eighteenTwentyFive = sfDoc.get("eighteenTwentyFive") + 1;
        final twentyFivePlus = sfDoc.get("twentyFivePlus") + 1;
        transaction.update(sfDocRef, {"totalUsers": totalUsers, "classes": classes, "discoveryOption1": discoveryOption1,
        "discoveryOption2": discoveryOption2, "en": en, "ar": ar, "female": female, "male": male, "underEighteen": underEighteen,
        "eighteenTwentyFive": eighteenTwentyFive, "twentyFivePlus": twentyFivePlus});
      });
    });
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