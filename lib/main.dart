import 'package:flutter/material.dart';
import './screens/homescreen.dart';
import './screens/firstGame/toturial.dart';
import './screens/firstGame/Countdown.dart';
import './screens/SecondGame/toturial.dart';
import './screens/SecondGame/Countdown.dart';

void main() {
  runApp(const MyApp());
}
//tt

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games app',
      initialRoute: '/',

      routes: {
        '/' : (context) => const Homescreen(),
        '/firstgame_tutorial' : (context) => const Toturial_first(),
        '/Countdown_firstgame' : (context) =>  CountdownFirstgame(),
        '/SecondGame_tut' : (context) =>  const second_tutorial(),
        '/Countdown_Second' : (context) =>  CountdownSecondGame(),        
      },
    );
  }
}
