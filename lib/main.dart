import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_birth_app/views/signUpView.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(GetMaterialApp(home: Signupview()));
}

