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
        '/FirstGame': (context) => const FirstGame(),
        '/SecondGame': (context) => const Instructions(),
        '/ThirdGame': (context) =>  Gameboard(),   // to be here 
        '/FourthGame': (context) => const MohamedGame(),
        '/FifthGame': (context) => const FifthGame(),
        '/SixthGame': (context) => const SameColor(),
      },
    );
  }
}
