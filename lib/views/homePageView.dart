import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/controllers/homePageController.dart';
import 'package:real_birth_app/views/QRView.dart';
import 'package:real_birth_app/views/articleListView.dart';
import 'package:real_birth_app/views/pdfListView.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepageview extends StatelessWidget{

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
  final control = Homepagecontroller();

  @override
  Widget build(BuildContext context){
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(leading: null, title: Text("Real Birth App"),),
      bottomNavigationBar: NavigationBar(onDestinationSelected: (int index){
        setState(() {
          currentPageIndex = index;
        });
      }, 
        selectedIndex: currentPageIndex,
        destinations: const<Widget>[
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.link), label: 'Workshop'),
        NavigationDestination(icon: Icon(Icons.archive), label: 'resources'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Store'),
        NavigationDestination(icon: Icon(Icons.calendar_today,), label: 'Bookings')
        ],
      ),
      body: <Widget>[

        //HOME
        Card( color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: Text("Home Page"),
          )
        ),

        //Workshop
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(onPressed:() => _launchURL() , child: Text("Link To Workshop")),
                ElevatedButton(onPressed:() => QR(), child: Text("QR Scanner"))
              ],
            )
          ),
        ),

        //Resources
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child:Column(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => iFramePage(), child: Text("Press"))), 
                Expanded(child: ElevatedButton(onPressed: () => pdfPage(), child: Text("PDF"))),
                Expanded(child: ElevatedButton(onPressed: () => iFramePage(), child: Text("Press"))),
                Expanded(child: ElevatedButton(onPressed: () => iFramePage(), child: Text("Press")))
              ]
            )
          ),
        ),

        //TBD
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: Text("In Development"),
          ),
        ),
        
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: Text("In Development"),
          )
        )
      ][currentPageIndex],
    );
  }

  void iFramePage(){
    Get.to(Articlelistview());
  }

  void pdfPage(){
    Get.to(Pdflistview());
  }

  Future<void> _launchURL() async {
   final Uri _url = Uri.parse('https://therealbirthworkshop.online/public/');
   if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
    }
  }
  void QR(){
    Get.to(MobileScannerSimple());
  }

}