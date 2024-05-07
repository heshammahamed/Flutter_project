import 'dart:async';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class FifthGame extends StatefulWidget {
  const FifthGame({super.key});

  @override
  State<FifthGame> createState() => _FifthGameState();
}

class _FifthGameState extends State<FifthGame> {
// variables

  int _secondsRemaining = 30;
  late Timer _timer;
  int score = 0;

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent; // Set default color
  bool displayFeedback = false;
  late Timer _feedbackTimer =
      Timer(Duration.zero, () {}); // Initialize with an empty timer

  List<String> directionsList = ["Down", "Up", "Left", "Right"];
  String swap = "right"; // wich direction the user swap
  List iconDirections = [
    FontAwesomeIcons.arrowDown,
    FontAwesomeIcons.arrowUp,
    FontAwesomeIcons.arrowLeft,
    FontAwesomeIcons.arrowRight
  ];
  List arrowColors = [
    Colors.red,
    Colors.green,
    Colors.red,
    Colors.green,
    Colors.red
  ];
  String direction = "Right"; // the direction wich display in the screen
  var iconDirection = FontAwesomeIcons.arrowDown;
  String iconDirectionString = "Down"; // arrow direction
  var arrowColor = Colors.red;
  bool directionSwapped = false;
  int i =
      0; // used to pick up the same value from the iconDirections list and direction list

  changeDirectionOfArrow() {
    i = Random().nextInt(4);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _feedbackTimer.cancel(); // Cancel the feedback timer on dispose
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          _showPopup();
        }
      });
    });
  }

  void _startFeedbackTimer() {
    setState(() {
      displayFeedback = true;
    });

    _feedbackTimer = Timer(Duration(milliseconds: 1000), () {
      setState(() {
        displayFeedback = false;
      });
    });
  }

  void _showPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Time Is Over"),
          content: Text("Your Score : $score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to the main menu
                // You can replace '/home' with your main menu route
                Navigator.pushNamed(context, '/');
              },
              child: const Text("Main Menu"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Rebuild the current screen
                setState(() {
                  _secondsRemaining = 30; // Reset timer
                  score = 0; // Reset Score
                  _startTimer(); // Start timer again
                });
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  checkSwap() {
    if (!directionSwapped) {
      if (arrowColor == Colors.green) {
        if (iconDirectionString == swap) {
          setState(() {
            score = score + 500;
            feedbackMessage = "Correct +100";
            feedbackColor = Colors.green;
            displayFeedback = true;
          });
        } else {
          setState(() {
            score = score - 1000;
            feedbackMessage = "Wrong -1000";
            feedbackColor = Colors.red;
            displayFeedback = true;
            if (score < 0) {
              score = 0;
            }
          });
        }
      } else {
        if (direction == swap) {
          setState(() {
            score = score + 500;
            feedbackMessage = "Correct +100";
            feedbackColor = Colors.green;
            displayFeedback = true;
          });
        } else {
          setState(() {
            score = score - 1000;
            feedbackMessage = "Wrong -40";
            feedbackColor = Colors.red;
            displayFeedback = true;
            if (score < 0) {
              score = 0;
            }
          });
        }
      }

      changeDirectionOfArrow();
      setState(() {
        direction = directionsList[Random().nextInt(4)];
        arrowColor = arrowColors[Random().nextInt(5)];
        iconDirection = iconDirections[i];
        iconDirectionString = directionsList[i];
        directionSwapped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // back ground color for the screen
      backgroundColor: const Color(0xFF161616),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 5),
          ),
          child: Column(children: [
            // first child in the column
            Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(width: 2, color: Colors.yellow)),
                width: 250,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Timer section

                      Container(
                          child: Text("Timer : $_secondsRemaining",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25))),

                      // Score section

                      Container(
                          child: Text("Score : ${score}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ])),

            // space between the first and second child in column
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),

            // second element in the tree
            GestureDetector(
                onVerticalDragUpdate: (details) {
                  int sensitivity = 8;

                  if (details.delta.dy > sensitivity) {
                    swap = "Down";
                    directionSwapped = false;
                  }

                  if (details.delta.dy < -sensitivity) {
                    swap = "Up";
                    directionSwapped = false;
                  }
                },
                onHorizontalDragUpdate: (details) {
                  int sensitivity = 8;

                  if (details.delta.dx > sensitivity) {
                    swap = "Right";
                    directionSwapped = false;
                  }

                  if (details.delta.dx < -sensitivity) {
                    swap = "Left";
                    directionSwapped = false;
                  }
                },
                onVerticalDragEnd: (details) {
                  Timer(const Duration(milliseconds: 200), () {
                    checkSwap();
                  });
                },
                onHorizontalDragEnd: (details) {
                  Timer(const Duration(milliseconds: 200), () {
                    checkSwap();
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(children: [
                      // show swap text and direction text
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Row(
                          children: [
                            const Text("Swap : ",
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 40)),
                            Text(direction,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 35)),
                          ],
                        ),
                      ),

                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      // show the arrow icon

                      Center(
                          child: FaIcon(
                        iconDirection,
                        color: arrowColor,
                        size: 190.0,
                      ))
                    ]))),
          ])),
    );
  }
}