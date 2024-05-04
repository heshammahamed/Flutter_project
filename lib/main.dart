import 'package:flutter/material.dart';
import './screens/homescreen.dart';
import 'screens/Monaia/FirstGame.dart';
import 'screens/Ahmed/SecondGame.dart';
import 'screens/Kholoud/ThirdGame.dart';
import 'screens/Mohamed/FourthGame.dart';
import 'screens/FifthGame/FifthGame.dart';
import 'screens/SameColor/sameColor.dart';

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
        '/': (context) => const Homescreen(),
        '/FirstGame': (context) => FirstGame(),
        '/SecondGame': (context) => SecondGame(),
        '/ThirdGame': (context) => ThirdGame(),
        '/FourthGame': (context) => FourthGame(),
        '/FifthGame': (context) => FifthGame(),
        '/SixthGame': (context) => SameColor(),
      },
    );
  }
}
