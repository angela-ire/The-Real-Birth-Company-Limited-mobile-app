
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/bagChecklistController.dart';

class Bagchecklistview extends StatefulWidget{
  const Bagchecklistview({super.key});
  
  @override
  _Bagchecklistview createState() => _Bagchecklistview();}

class _Bagchecklistview extends State<Bagchecklistview>{
  final controller = Bagchecklistcontroller();
  final TextEditingController con = TextEditingController();

  void openDialouge(String? DocId){
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(controller: con,),
      actions: [ElevatedButton(onPressed:(){ controller.addBagItem(con.text, DocId); con.clear(); Navigator.pop(context);}, child: Text("Add"))],
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body : Center(
        child: Column(
          children: [
          StreamBuilder<QuerySnapshot>(stream: controller.fetchBagItem(), builder:(context, snapshot){
            if (snapshot.hasData){
              List bagItem = snapshot.data!.docs;
              return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                itemCount: bagItem.length,
                itemBuilder:  (context, index){
                DocumentSnapshot item = bagItem[index];
                String id = item.id;


                Map<String, dynamic> data = item.data() as Map<String, dynamic>;                        
                if(data["checked"] == true){
                  return ListTile(title: Text(data["item"]),
                  trailing: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(onPressed: (){controller.checkItem(false, id);} ,icon: Icon(Icons.check_circle_outline)),
                    IconButton(onPressed: (){openDialouge(id);}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){controller.deleteItem(id);}, icon: Icon(Icons.delete))
                    ]
                  ));
                }
                else{
                  return ListTile(title: Text(data["item"]),
                  trailing: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(onPressed: (){controller.checkItem(true, id);} ,icon: Icon(Icons.highlight_off)),
                    IconButton(onPressed: (){openDialouge(id);}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){controller.deleteItem(id);}, icon: Icon(Icons.delete))
                    ]
                  ));

                }
                });
            }
            else{
              return Text("");
            }
          }),
          ElevatedButton(onPressed: () {openDialouge(null);}, child: Text("Add Note"))
        ]),
      )
    );
  }
}