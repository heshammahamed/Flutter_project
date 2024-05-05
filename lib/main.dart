import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/homescreen.dart';
import 'screens/Monaia/FirstGame.dart';
import 'screens/Ahmed/instructions.dart';
import 'screens/Kholoud/ThirdGame.dart';
import 'screens/Mohamed/FourthGame.dart';
import 'screens/FifthGame/FifthGame.dart';
import 'screens/SameColor/sameColor.dart';
import 'package:game_project/board.dart';

void main() {
  runApp(const MyApp());
}
//tt

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Gameboard(),
      title: 'Games app',
      initialRoute: '/',
      routes: {
        '/': (context) => const Homescreen(),
        '/FirstGame': (context) => const FirstGame(),
        '/SecondGame': (context) => const Instructions(),
        '/ThirdGame': (context) => const ThirdGame(),
        '/FourthGame': (context) => const MohamedGame(),
        '/FifthGame': (context) => const FifthGame(),
        '/SixthGame': (context) => const SameColor(),
      },
    );
  }
}
