
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/acticleListController.dart';
import 'package:real_birth_app/models/articleModel.dart';
import 'package:real_birth_app/views/tempWebview.dart';

class Articlelistview extends StatelessWidget {
  final controller = Acticlelistcontroller();
  List<Articlemodel> articles = [];

   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Padding(padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children:[ StreamBuilder(stream: controller.fetchArticles(), builder: (context, snapshot){
            if (snapshot.hasData){
                articles = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  itemBuilder:  (context, index){
                    final item = articles[index];
                    return ListTile(title: Text(item.name), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewExample(link: item.link))),);
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