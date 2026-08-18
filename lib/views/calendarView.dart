import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/calendarController.dart';
import 'package:real_birth_app/models/appointmentModel.dart';

class Calendarview extends StatefulWidget{
  const Calendarview({super.key});
  
  @override
  _Calendarview createState() => _Calendarview();}

class _Calendarview extends State<Calendarview>{
  Calendarcontroller controller = Calendarcontroller();
  TextEditingController con = TextEditingController();
  List<Appointmentmodel>? d;
  List<DateTime?> _dates = [];
  late Stream STREAM;

  @override
  void initState() {
    super.initState();
    STREAM = controller.getDates();
  }

  void openDialog(List<DateTime?> oldDates, List<DateTime> newDates){
   showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(controller: con,),
      actions: [ElevatedButton(onPressed:(){ controller.changeDate(oldDates, newDates, con.text);
      _dates = newDates; Navigator.pop(context); con.clear();}, child: Text("Add"))],
      )
    );
  }

  Future<void> editDialog(List<DateTime?> oldDates, List<DateTime> newDates) async {
    String exist = await controller.getName(oldDates, newDates);
    con.text = exist;
    showDialog(context: context, 
    builder: (context) => AlertDialog(
      content: TextField(controller: con,),
      actions: [ElevatedButton(onPressed: (){controller.updateDate(oldDates, newDates, con.text); rebuildAllChildren(context); Navigator.pop(context); con.clear();}, child: Text("Update"),),
      ElevatedButton(onPressed: (){controller.changeDate(oldDates, newDates, null); rebuildAllChildren(context); Navigator.pop(context); con.clear();}, child: Text("Delete"))],
    )
    );
  }

  void preDialog(List<DateTime?> oldDates, List<DateTime> newDates){
     _dates = newDates;
    if(oldDates.length > newDates.length){
      editDialog(oldDates, newDates);
      _dates = newDates;
    }
    else{
      openDialog(oldDates, newDates);
    }
  }

  void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }
  (context as Element).visitChildren(rebuild);
}

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      appBar: AppBar(),
      body:
      StreamBuilder(stream: STREAM, builder: (context, snapshot){
      if(snapshot.hasData){
        d = snapshot.data;
        List<DateTime?> x = [];
        for(int i = 0; i < d!.length; i++){
          x.add(d![i].date);
        }
        _dates = x;
        return Center( 
          child: Column(
            children: [
              CalendarDatePicker2(
              config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.multi,),
              value: _dates,
              onValueChanged: (dates) {preDialog(_dates ,dates); rebuildAllChildren(context);},),
              ElevatedButton(onPressed:(){}, child:Text("data"))
            ]
          )
        );
      }
      else{return Text("");}
      }
    )
  );
  }
}