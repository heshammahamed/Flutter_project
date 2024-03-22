import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import '../../var.dart';
class CountdownFirstgame extends StatefulWidget {
  @override
  _CountdownFirstgameState createState() => _CountdownFirstgameState();
}

class _CountdownFirstgameState extends State<CountdownFirstgame> {
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
          Navigator.pushReplacementNamed(context, "/FirstGame");
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
          progressColor: Colors.blue,
          center:  Text("$_countdown" , style: const TextStyle(fontFamily: 'POP' , color: Colors.white, fontSize: 100),)),      
    ));
  }

  @override
  void dispose() {
    _timer.cancel(); 
    super.dispose();
  }
}