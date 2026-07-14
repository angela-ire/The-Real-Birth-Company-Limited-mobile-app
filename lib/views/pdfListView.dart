import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/pdfListController.dart';
import 'package:real_birth_app/models/articleModel.dart';
import 'package:real_birth_app/views/pdfView.dart';

class Pdflistview extends StatelessWidget {
  final controller = Pdflistcontroller();
  List<Articlemodel> articles = [];
  Pdflistview({super.key});

   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Padding(padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:[ StreamBuilder(stream: controller.fetchPdf(), builder: (context, snapshot){
            if (snapshot.hasData){
                articles = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder:  (context, index){
                    final item = articles[index];
                    return ListTile(title: Text(item.name), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Pdfview(link: item))),);
                  },
                );
              }
            else{
              return Text("Loading");
            }
          }),
        ]),
        )
        )
      ),
    );
  }
}