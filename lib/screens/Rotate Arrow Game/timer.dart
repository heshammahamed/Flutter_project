import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import "RotateArrowGame.dart";
import 'dart:async';

class TimerGame extends StatefulWidget {
  const TimerGame({super.key});

  @override
  State<TimerGame> createState() => _TimerGameState();
}

class _TimerGameState extends State<TimerGame> {
  int _secondsRemaining = 3;
  double percent = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          percent = _secondsRemaining / 3.0;
        } else {
          timer.cancel();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SecondGame()),
          );
          // Timer completed
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return Scaffold(
        backgroundColor: color.backgroundForHomeScreen,
        body: Center(
          child: CircularPercentIndicator(
              radius: 300,
              lineWidth: 10,
              percent: percent,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0xFF1976D2),
              center: Text(
                "$_secondsRemaining",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: color.textForHomeScreen),
              )),
        ));
  }
}
