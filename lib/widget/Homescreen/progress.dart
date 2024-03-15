import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

double levelpercent = 0.4;

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: const BoxDecoration(
        color: Color(0xFF28292D),
      ),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
    child:  
    Row (
      crossAxisAlignment: CrossAxisAlignment.center,

      children : [
        CircularPercentIndicator(
          radius: 130,
          lineWidth: 8,
          percent: levelpercent,
          circularStrokeCap: CircularStrokeCap.round,
          center: const Text("LV.0" , style: TextStyle(fontFamily: 'POP' , color: Colors.white, fontSize: 30),))
      ], 

      
    ));
  }
}