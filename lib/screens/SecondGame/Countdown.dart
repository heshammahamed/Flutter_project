import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import '../../var.dart';

class CountdownSecondGame extends StatefulWidget {
  @override
  _CountdownSecondGameState createState() => _CountdownSecondGameState();
}

class _CountdownSecondGameState extends State<CountdownSecondGame> {
  int _countdown = 3;
  late Timer _timer;
    double per = 1;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
          Navigator.pushReplacementNamed(context, "/SecondGame");
      } else {
        setState(() {
        _countdown --; 
        if (per != 0.0) {per = per - 0.3;}  
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homescreen,
      body: Center(
      child :
        CircularPercentIndicator(
          radius: 300,
          lineWidth: 10,
          percent: per ,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.green,
          center:  Text("$_countdown" , style: const TextStyle(fontFamily: 'POP' , color: Colors.white, fontSize: 100),)),      
    ));
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}