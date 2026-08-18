import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/birthPlannerController.dart';

class Birthplannerview extends StatefulWidget {
  const Birthplannerview({super.key});

  @override
  _Birthplannerview createState() => _Birthplannerview();}

  class _Birthplannerview extends State<Birthplannerview>{
  final controller = Birthplannercontroller(); 
  final TextEditingController con = TextEditingController();
  late Stream<QuerySnapshot> STREAMNOTES;
  late Stream<QuerySnapshot> STREAMPROCEDURES;
  late Stream<QuerySnapshot> STREAMCONDITIONS;
  
  @override
  void initState() {
    super.initState();
    STREAMNOTES = controller.fetchNotes("birthNotes");
    STREAMCONDITIONS = controller.fetchNotes("birthConditions");
    STREAMPROCEDURES = controller.fetchNotes("birthProcedures");
  }

  void openDialouge(String type, String? DocId){
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(controller: con,),
      actions: [ElevatedButton(onPressed:(){ controller.addNote(type ,con.text, DocId); con.clear(); Navigator.pop(context);}, child: Text("Add"))],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(onPressed: () => Navigator.of(context).pop()),
            bottom: const TabBar(
              tabs: [
                Tab(text: "notes",),
                Tab(text: "Procedures",),
                Tab(text: "Conditions",),
              ],
            ),
            title: const Text('Tabs Demo'),
            
          ),
          body: TabBarView(
            children: [

              //Notes
              Center(child:
                Column(children: [
                  StreamBuilder<QuerySnapshot>(stream: STREAMNOTES , builder: (context, snapshot){
                    if(snapshot.hasData){
                      List note = snapshot.data!.docs;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: note.length,
                        itemBuilder:  (context, index){
                        DocumentSnapshot item = note[index];
                        String id = item.id;

                        Map<String, dynamic> data = item.data() as Map<String, dynamic>;                        

                        return ListTile(title: Text(data["text"]), 
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(onPressed: (){openDialouge("birthNotes", id);}, icon: Icon(Icons.settings)),
                          IconButton(onPressed: (){controller.deleteNote("birthNotes", id);}, icon: Icon(Icons.delete))
                        ],));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthNotes", null);}, child: Text("Add Note")),
                ]),
              ),
            
              //Procedures
              Center(child:
                Column(children: [
                  StreamBuilder(stream: STREAMPROCEDURES , builder: (context, snapshot){
                    if(snapshot.hasData){
                      List note = snapshot.data!.docs;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: note.length,
                        itemBuilder:  (context, index){
                        DocumentSnapshot item = note[index];
                        String id = item.id;

                        Map<String, dynamic> data = item.data() as Map<String, dynamic>;                        

                        return ListTile(title: Text(data["text"]), 
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(onPressed: (){openDialouge("birthProcedures", id);}, icon: Icon(Icons.settings)),
                          IconButton(onPressed: (){controller.deleteNote("birthProcedures", id);}, icon: Icon(Icons.delete))
                        ],));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthProcedures", null);}, child: Text("Add Note")),
                ]),
              ),

              //Conditions
              Center(child:
                Column(children: [
                  StreamBuilder(stream: STREAMCONDITIONS , builder: (context, snapshot){
                    if(snapshot.hasData){
                      List note = snapshot.data!.docs;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: note.length,
                        itemBuilder:  (context, index){
                        DocumentSnapshot item = note[index];
                        String id = item.id;

                        Map<String, dynamic> data = item.data() as Map<String, dynamic>;                        

                        return ListTile(title: Text(data["text"]), 
                        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(onPressed: (){openDialouge("birthConditions", id);}, icon: Icon(Icons.settings)),
                          IconButton(onPressed: (){controller.deleteNote("birthConditions", id);}, icon: Icon(Icons.delete))
                        ],));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthConditions", null);}, child: Text("Add Note")),
                ]),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}