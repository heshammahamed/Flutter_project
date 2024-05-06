import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/homescreen.dart';
import 'screens/Monaia/BiggestNumInstructions.dart';
import 'screens/Ahmed/ArrowInstructions.dart';
import 'screens/Kholoud/ThirdGame.dart';
import 'screens/Mohamed/ColorBoxInstructions.dart';
import 'screens/FifthGame/DirectionInstructions.dart';
import 'screens/SameColor/SameColorInstructions.dart';
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
      // home: Gameboard(),
      /*
      
      there is error occured when we run the main dart because 
      there are already initial route  for the app so we can not add home property.


      so i change the Gameboard() secreen to be in kholoud section in the home screen 
      
      */
      title: 'Games app',
      initialRoute: '/',
      routes: {
        '/': (context) => const Homescreen(),
        '/FirstGame': (context) => const BiggestNumInstructions(),
        '/SecondGame': (context) => const ArrowInstructions(),
        '/ThirdGame': (context) => Gameboard(), // to be here
        '/FourthGame': (context) => const ColorBoxInstructions(),
        '/FifthGame': (context) => const DirectionInstructions(),
        '/SixthGame': (context) => const SameColorInstructions(),
      },
    );
  }
}
