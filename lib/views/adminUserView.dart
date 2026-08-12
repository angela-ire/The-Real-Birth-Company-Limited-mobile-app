import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/adminUserController.dart';
import 'package:real_birth_app/models/articleTrackingModel.dart';
import 'package:real_birth_app/models/userModel.dart';

class Adminuserview extends StatefulWidget{
  final userModel link;
  const Adminuserview({super.key, required this.link});

  @override
  State<Adminuserview> createState() => _Adminuserview();
}

class _Adminuserview extends State<Adminuserview>{
  final controller = Adminusercontroller();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(future: controller.getVisitedArticles("iKECUNKfC6hhfJc2CLqTZUaomJv1"), builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return StreamBuilder(stream: controller.getIndividualArticle("iKECUNKfC6hhfJc2CLqTZUaomJv1", snapshot.data![index]), builder: (context, snapshot){
                });
              },
            );
          }
          else{return Text("");}
        }),
    ));
  }
}