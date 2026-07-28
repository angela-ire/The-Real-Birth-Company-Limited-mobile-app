
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
        child: StreamBuilder(stream: controller.getContraction(), builder: (context, snapshot){
          if(snapshot.hasData){
            controller.pageModel = snapshot.data;
            return SingleChildScrollView( child: Column(
            children: [
            //Start and end contraction button
            ElevatedButton(onPressed:(){controller.contractionSwitch();},child: Obx(() => Text("${controller.startStop}"))),

            Text("average = ${controller.returnAsMinutes(controller.getAverage(controller.pageModel!))}"),
                
            Text("amount in last hour ${controller.getTotalOfHour(controller.pageModel!).toString()}"),
            
            Text("Frequency of last hour ${controller.returnAsMinutes(controller.getFrequencyPastHour(controller.pageModel!))}"),

            Text("Frequency ${controller.returnAsMinutes(controller.getFrequency(controller.pageModel!))}"),

            //List all existing contractions   
            ListView.builder(shrinkWrap: true, physics: ScrollPhysics(), scrollDirection: Axis.vertical,
            itemCount: controller.pageModel!.length,
            itemBuilder:  (context, index){
            Contractionmodel curr = controller.pageModel![index];
            //Formats into correct 24hour clock
            String _stop = DateFormat.Hm().format(curr.endTime);  
            String _start = DateFormat.Hm().format(curr.startTime);
            return ListTile(title: Text("$_start until $_stop lasted ${controller.returnAsMinutes(curr.duration)}"),);})   
          ]));
          }
          else{return Text("");}
      }))
    ,);
    }
  }