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
  List<Appointmentmodel>? d;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      StreamBuilder(stream: controller.getDates(), builder: (context, snapshot){
      if(snapshot.hasData){    
        d = snapshot.data;
        List<DateTime?> _dates = [];
        for(int i = 0; i < d!.length; i++){
          _dates.add(d![i].date);
        }
        return Center( 
          child: Column(
            children: [
              CalendarDatePicker2(
              config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.multi,),
              value: _dates,
              onValueChanged: (dates) {_dates = controller.changeDate(_dates ,dates);},),
              ElevatedButton(onPressed:(){}, child:Text("data"))
            ]
          )
        );
      }
      else{
        return Text("");
      }
      }
    )
  );
  }
}