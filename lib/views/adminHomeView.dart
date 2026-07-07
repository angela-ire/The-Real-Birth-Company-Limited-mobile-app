
import 'package:flutter/material.dart';

class Adminhomeview extends StatelessWidget{

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
}