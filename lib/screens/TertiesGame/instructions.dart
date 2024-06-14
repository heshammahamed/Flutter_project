import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'timer.dart';

class InstructionsBuildGame extends StatefulWidget {
  const InstructionsBuildGame({super.key});

  @override
  State<InstructionsBuildGame> createState() => _InstructionsBuildGameState();
}

class _InstructionsBuildGameState extends State<InstructionsBuildGame> {
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
            'Tetris Game',
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
                  '-  Your goal is to manipulate falling tetrominoes to create complete horizontal lines at the bottom',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '-  You can move tetrominoes left or right using the left and right arrow',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '- To rotate them, simply press the rotate icon which shown in the bottom',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '-  when you successfully create a horizontal line with no gaps across the playing area it will vanish and you will get +100 points.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: color.textForHomeScreen,
                  )),
              Text(
                  '-  The game will over if the tetrominoes stack up to the top of the screen.',
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
