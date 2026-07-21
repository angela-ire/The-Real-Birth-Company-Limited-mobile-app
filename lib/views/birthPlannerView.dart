import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/birthPlannerController.dart';
import 'package:real_birth_app/models/birthNotes.dart';


class Birthplannerview extends StatefulWidget {
  const Birthplannerview({super.key});

  @override
  _Birthplannerview createState() => _Birthplannerview();}

  class _Birthplannerview extends State<Birthplannerview>{
  final controller = Birthplannercontroller(); 
  List<Birthnotes>? _note;
  final TextEditingController con = TextEditingController();

  void openDialouge(String type){
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(controller: con,),
      actions: [ElevatedButton(onPressed:(){ controller.addNote(type ,con.text);}, child: Text("Add"))],
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
                  StreamBuilder(stream: controller.fetchNotes("birthNotes") , builder: (context, snapshot){
                    if(snapshot.hasData){
                      _note  = snapshot.data;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: _note!.length,
                        itemBuilder:  (context, index){
                        final item = _note![index];
                        return ListTile(title: Text(item.title));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthNotes");}, child: Text("Add Note")),
                ]),
              ),
            
              //Procedures
              Center(child:
                Column(children: [
                  StreamBuilder(stream: controller.fetchNotes("birthProcedures") , builder: (context, snapshot){
                    if(snapshot.hasData){
                      _note  = snapshot.data;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: _note!.length,
                        itemBuilder:  (context, index){
                        final item = _note![index];
                        return ListTile(title: Text(item.title));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthProcedures");}, child: Text("Add Note")),
                ]),
              ),

              //Conditions
              Center(child:
                Column(children: [
                  StreamBuilder(stream: controller.fetchNotes("birthConditions") , builder: (context, snapshot){
                    if(snapshot.hasData){
                      _note  = snapshot.data;
                      return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                        itemCount: _note!.length,
                        itemBuilder:  (context, index){
                        final item = _note![index];
                        return ListTile(title: Text(item.title));
                        }
                      );
                    }
                    else{return Text("");}
                }
                ),
                  ElevatedButton(onPressed: () {openDialouge("birthConditions");}, child: Text("Add Note")),
                ]),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}