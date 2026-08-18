import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/pdfListController.dart';
import 'package:real_birth_app/models/articleModel.dart';
import 'package:real_birth_app/views/pdfView.dart';

class Pdflistview extends StatefulWidget {
  Pdflistview({super.key});
  @override
  State<Pdflistview> createState() => _Pdflistview(); 
}

class _Pdflistview extends State<Pdflistview>{
  final controller = Pdflistcontroller();
  List<Articlemodel> articles = [];
  late Stream STREAM;
  
  @override
  void initState() {
    super.initState();
    STREAM = controller.fetchPdf();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Padding(padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:[ StreamBuilder(stream: STREAM, builder: (context, snapshot){
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