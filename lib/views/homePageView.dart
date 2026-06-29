import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/homePageController.dart';

class Homepageview extends StatelessWidget{
  final control = Homepagecontroller();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Navigation());
  }
}

class Navigation extends StatefulWidget{
  const Navigation ({super.key});
  @override
  State<Navigation> createState() => _Navigation();
}

class _Navigation extends State<Navigation>{
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: NavigationBar(onDestinationSelected: (int index){
        setState(() {
          currentPageIndex = index;
        });
      }, destinations: const<Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.link), label: 'Workshop'),
        NavigationDestination(icon: Icon(Icons.archive), label: 'resources'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Store'),
        NavigationDestination(icon: Icon(Icons.calendar_today,), label: 'Bookings')
      ],),
    );
  }
}