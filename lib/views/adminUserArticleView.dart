import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/adminUserArticleController.dart';
import 'package:real_birth_app/models/userModel.dart';

class Adminuserarticleview extends StatefulWidget{
  final userModel link;
  final String article;
  const Adminuserarticleview({super.key, required this.link, required this.article});

  @override
  State<Adminuserarticleview> createState() => _Adminuserarticleview();
}

class _Adminuserarticleview extends State<Adminuserarticleview>{
  final controller = Adminuserarticlecontroller();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: 
        FutureBuilder(future: controller.getAll(widget.link.uid, widget.article), builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder( itemCount:snapshot.data!.length, itemBuilder:(context, index) {
              return ListTile(title: Text(snapshot.data![index].timeStamp.toString()));
            },);
          }
          else{
            return(Text(""));
          }
        }),
      ),
    );
  }
}