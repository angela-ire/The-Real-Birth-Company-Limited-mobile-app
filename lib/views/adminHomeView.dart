import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/adminHomeViewController.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/views/adminUserView.dart';

class Adminhomeview extends StatelessWidget{
  const Adminhomeview({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationAdmin());
  }
}

class NavigationAdmin extends StatefulWidget{
  const NavigationAdmin ({super.key});
  @override
  State<NavigationAdmin> createState() => _NavigationAdmin();
}

class _NavigationAdmin extends State<NavigationAdmin>{
  int currentPageIndex = 0;
  final controller = Adminhomeviewcontroller();

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
            child: Text("Admin Home Page"),
          )
        ),

        //Workshop
        Card(color: Color.fromARGB(255, 251, 234, 247),
  
        ),

        //Resources
        Card(color: Color.fromARGB(255, 251, 234, 247)
        ),

        //UserList
        Card(color: Color.fromARGB(255, 251, 234, 247),
          child: Center(
            child: StreamBuilder(stream: controller.fetchUsers(), builder: (context, snapshot){
              if(snapshot.hasData){
                List userAmounts = snapshot.data!.docs;
                return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                itemCount: userAmounts.length,
                itemBuilder:  (context, index){
                  DocumentSnapshot item = userAmounts[index];
                  String id = item.id;

                  userModel currUser = userModel.fromJson(item.data() as Map<String, dynamic>?);
                  return ListTile(title: Text(currUser.name), onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> Adminuserview(link: currUser)));},);
                });
              }
              else{return Text("");}
            }),
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
}