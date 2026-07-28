import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_birth_app/controllers/homePageController.dart';
import 'package:real_birth_app/views/QRView.dart';
import 'package:real_birth_app/views/articleListView.dart';
import 'package:real_birth_app/views/bagChecklistView.dart';
import 'package:real_birth_app/views/birthPlannerView.dart';
import 'package:real_birth_app/views/contractionTrackerView.dart';
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
        NavigationDestination(icon: Icon(Icons.person_pin), label: 'Profile'),
        NavigationDestination(icon: Icon(Icons.construction), label: 'Tools'),
        NavigationDestination(icon: Icon(Icons.book), label: 'Resources')
        ],
      ),
      body: <Widget>[

        //HOME
        Card( color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: FutureBuilder(future: control.getWeeks(), builder: (context, snapshot){
              if(snapshot.hasData){
                return Text("${(40 - snapshot.data!).toString()} weeks along");
              }
              else{return Text("");}
            }),
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

        //Profile
        Card(color: Color.fromARGB(255, 251, 234, 247),
        ),

        //Tools
        Card(color: Color.fromARGB(255, 251, 234, 247),
        child: Center(
            child: Column(
              children: [
              FutureBuilder(future: control.getWeeks(), builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text("${(40 - snapshot.data!).toString()} weeks along");
                }
                else{return Text("");}
              }),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Flexible(child: ElevatedButton(onPressed: () => {}, child: Text("Pregnancy Tools"))),
              Flexible(child: ElevatedButton(onPressed: () => {}, child: Text("Birth Tools"))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Flexible(child: ElevatedButton(onPressed: () => {}, child: Text("Postnatal Tools"))),
                Flexible(child: ElevatedButton(onPressed: () => {}, child: Text("Family Tools"))),
              ]
              )
            ]
            )
          ),
                  ),
        
        //Resources
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Flexible(child: ElevatedButton(onPressed: () => iFramePage(), child: Text("Press"))),
              Flexible(child: ElevatedButton(onPressed: () => pdfPage(), child: Text("PDF"))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Flexible(child: ElevatedButton(onPressed: () => birthPlanner(), child: Text("BIRTH PLANNER"))),
                Flexible(child: ElevatedButton(onPressed: () => bagChecklist(), child: Text("Checklist"))),
              ]
              )
            ]
            )
          ),
        )
      ][currentPageIndex],
    );
  }

  void contractionTracker(){
    Get.to(Contractiontrackerview());
  }

  void bagChecklist(){
    Get.to(Bagchecklistview());
  }

  void iFramePage(){
    Get.to(Articlelistview());
  }

  void pdfPage(){
    Get.to(Pdflistview());
  }

  void birthPlanner(){
    Get.to(Birthplannerview());
  }

  Future<void> _launchURL() async {
    control.urlTrack();
   final Uri _url = Uri.parse('https://therealbirthworkshop.online/public/');
   if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
    }
  }
  void QR(){
    Get.to(MobileScannerSimple());
  }

}