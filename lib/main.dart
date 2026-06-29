import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:real_birth_app/views/loginView.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:birth_picker/birth_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(GetMaterialApp(theme:ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFBEAF2))), home: Loginview()));
}
