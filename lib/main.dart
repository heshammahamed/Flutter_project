import 'package:flutter/material.dart';
import './screens/homescreen.dart';

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
      },
    );
  }
}
