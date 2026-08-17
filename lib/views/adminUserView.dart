import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/adminUserController.dart';
import 'package:real_birth_app/models/userModel.dart';
import 'package:real_birth_app/views/adminUserArticleView.dart';

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
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(future: controller.getVisitedArticles(widget.link.uid), builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(snapshot.data![index]), onTap: () {
                  {Navigator.push(context, MaterialPageRoute(builder: (context)=> Adminuserarticleview(link: widget.link, article: snapshot.data![index],)));}
                },);
              },
            );
          }
          else{return Text("");}
        }),
    ));
  }
}