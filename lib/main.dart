import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/views/adminHomeView.dart';
import 'package:real_birth_app/views/homePageView.dart';
import 'package:real_birth_app/views/loginView.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:birth_picker/birth_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  final db = FirebaseFirestore.instance;
  runApp(GetMaterialApp(theme:ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 251, 234, 247),colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFBEAF2))), 
  home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
      if (snapshot.hasData){
        return Homepageview();
    }
    else{return Loginview();}
  })));
}
