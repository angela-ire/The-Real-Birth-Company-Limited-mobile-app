
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:real_birth_app/controllers/contractionTrackerController.dart';
import 'package:real_birth_app/models/contractionModel.dart';

class Contractiontrackerview extends StatefulWidget{
  const Contractiontrackerview({super.key});
  
  @override
  _Contractiontrackerview createState() => _Contractiontrackerview();}

class _Contractiontrackerview extends State<Contractiontrackerview>{
  Contractiontrackercontroller controller = Contractiontrackercontroller();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed:(){controller.contractionSwitch();},child: Obx(() => Text("${controller.startStop}"))),
            StreamBuilder(stream: controller.getContraction(), builder: (context, snapshot){
              if(snapshot.hasData){
                controller.pageModel = snapshot.data;
                int numOf = controller.pageModel!.length;
                double total = 0;
                for(int i = 0; i < numOf; i++){
                  total = total + controller.pageModel![i].duration;
                }
                double avg = total / numOf;
                avg = double.parse(avg.toStringAsFixed(0));
                double mins = avg / 60;
                if(total == 0.0){
                  return Text("average");
                }
                else{
                  if(mins < 1){
                    mins = 0;
                  }
                  double secs = avg % 60;
                  if(secs < 10){
                    String s = "0${secs.truncate().toString()}";
                    return Text("average = ${mins.truncate().toString()}:$s");  
                  }
                  else{
                    return Text("average = ${mins.truncate().toString()}:${secs.truncate().toString()}");
                  }
                }
              }              
              else{return Text("");}
            }),

            StreamBuilder(stream: controller.getContraction(), builder:(context, snapshot){
              if(snapshot.hasData){
                controller.pageModel = snapshot.data;
                int length = controller.pageModel!.length;
                final curr = DateTime.now();
                int total = 0;
                for(int i = 0; i < length; i++){
                  if(curr.difference(controller.pageModel![i].endTime).inHours < 1){
                    total++;
                  }
                }
                return Text("amount in last hour ${total.toString()}");
              }
              else{return Text("");}
            }),

            StreamBuilder(stream: controller.getContraction(), builder: (context, snapshot){
              if(snapshot.hasData){
                controller.pageModel = snapshot.data;
                return ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
                itemCount: controller.pageModel!.length,
                itemBuilder:  (context, index){
                  Contractionmodel curr = controller.pageModel![index];
                  String _stop = DateFormat.Hm().format(curr.endTime);  
                  String _start = DateFormat.Hm().format(curr.startTime);
                  return ListTile(title: Text("$_start until $_stop lasted ${curr.duration}"),);
                });
              }
              else{return Text("Loading");}
            })
          ],
        ),
      ),
    );
    }
  }