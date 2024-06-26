import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import "timer.dart";

class ArrowInstructions extends StatefulWidget {
  const ArrowInstructions({super.key});

  @override
  State<ArrowInstructions> createState() => _ArrowInstructionsState();
}

class _ArrowInstructionsState extends State<ArrowInstructions> {
  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: color.gamesAppbar,
          title: const Text(
            'Rotate Arrow Game',
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: color.backgroundForHomeScreen,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: color.textForHomeScreen, width: 0.5),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'Game Instructions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: color.textForHomeScreen,
                      ),
                    ),
                  )),
              Text(
                  '-  You have to rotate the second arrow to match the direction of the first blue arrow',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '-  You have to collect as many points as possible before time runs out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text('-  Each correct matching you will gain +500 points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '-  If you get close to the correct matching you will gain +300 points',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  "-  If you didn't get the correct matching, you will lose -400 points",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TimerGame()),
                  );
                },
                color: const Color.fromARGB(255, 0, 149, 5), // Background color
                textColor: Colors.white, // Text color
                elevation: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  // You can customize the shape of the button here
                ),
                child: const Center(
                  child: Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
