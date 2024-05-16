import 'dart:async';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class FifthGame extends StatefulWidget {
  const FifthGame({super.key});

  @override
  State<FifthGame> createState() => _FifthGameState();
}

class _FifthGameState extends State<FifthGame> {
// variables

  int _secondsRemaining = 30;
  late Timer _timer;
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
    Score score = Provider.of<Score>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Time Is Over"),
          content: Text("Your Score : ${score.scoreForObservationGame}"),
          actions: [
            TextButton(
              onPressed: () {
                score.restartScoreForObservationGames();
                Navigator.of(context).pop();
                // Navigate to the main menu
                // You can replace '/home' with your main menu route
                Navigator.pushNamed(context, '/home');
              },
              child: const Text("Main Menu"),
            ),
            TextButton(
              onPressed: () {
                score.restartScoreForObservationGames();
                Navigator.of(context).pop();
                // Rebuild the current screen
                setState(() {
                  _secondsRemaining = 30; // Reset timer
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

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: true);
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    checkSwap() {
      if (!directionSwapped) {
        if (arrowColor == Colors.green) {
          if (iconDirectionString == swap) {
            setState(() {
              score.addScoreForObservationGames();
              feedbackMessage = "Correct +500";
              feedbackColor = Colors.green;
              displayFeedback = true;
            });
          } else {
            setState(() {
              score.minScoreForObservationGames();
              feedbackMessage = "Wrong -400";
              feedbackColor = Colors.red;
              displayFeedback = true;
            });
          }
        } else {
          if (direction == swap) {
            setState(() {
              score.addScoreForObservationGames();
              feedbackMessage = "Correct +500";
              feedbackColor = Colors.green;
              displayFeedback = true;
            });
          } else {
            setState(() {
              score.minScoreForObservationGames();
              feedbackMessage = "Wrong -400";
              feedbackColor = Colors.red;
              displayFeedback = true;
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

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black45,
            scrolledUnderElevation: 50,
            elevation: 10,
            centerTitle: true,
            backgroundColor: color.gamesAppbar,
            title: const Text(
              'Directions Game',
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
          body: Column(
            children: [
              const SizedBox(height: 20),
              // Timer & Score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: color.textForHomeScreen, width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 20)
                        ]),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: color.textForHomeScreen,
                        ),
                        Text(
                          ' Timer : $_secondsRemaining',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                            color: color.textForHomeScreen,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: color.textForHomeScreen, width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 20)
                        ]),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.leaderboard,
                          color: color.textForHomeScreen,
                        ),
                        Text(
                          ' Score : ${score.scoreForObservationGame}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                            color: color.textForHomeScreen,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ), // Timer & Score Row
              const SizedBox(
                height: 40,
              ),
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
                    _startFeedbackTimer();
                  });
                },
                onHorizontalDragEnd: (details) {
                  Timer(const Duration(milliseconds: 200), () {
                    checkSwap();
                    _startFeedbackTimer();
                  });
                },
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        color: color.gamesContainerStroke, width: 0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFE8F3FA),
                          blurRadius: 2,
                          offset: Offset(0, 0)),
                    ],
                    color: color.gamesContainer,
                    shape: BoxShape.rectangle,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: color.textForHomeScreen, width: 1),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Swap : $direction",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: "Montserrat",
                                  color: color.textForHomeScreen,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Visibility(
                          visible: displayFeedback,
                          child: Text(
                            feedbackMessage,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: feedbackColor),
                          ),
                        ), // Display feedback only when required,
                      ),
                      Center(
                          child: FaIcon(
                        iconDirection,
                        color: arrowColor,
                        size: 190.0,
                      ))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );

    /*Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black45,
        scrolledUnderElevation: 50,
        elevation: 10,
        centerTitle: true,
        backgroundColor: color.gamesAppbar,
        title: const Text(
          'Direction Game',
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      // back ground color for the screen
      backgroundColor: color.backgroundForHomeScreen,
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 5),
          ),
          child: Column(children: [
            // first child in the column
            Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 2, color: Colors.transparent)),
                width: 400,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Timer section

                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: color.textForHomeScreen),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: color.textForHomeScreen,
                            ),
                            Container(
                              child: Text("Timer : $_secondsRemaining",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: "Montserrat",
                                    color: color.textForHomeScreen,
                                  )),
                            )
                          ],
                        ),
                      ),

                      // Score section

                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: color.textForHomeScreen),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 0),
                                    blurRadius: 20)
                              ]),
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [
                            Icon(
                              Icons.leaderboard,
                              color: color.textForHomeScreen,
                            ),
                            Container(
                              child: Text(
                                  "Score : ${score.scoreForObservationGame}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: "Montserrat",
                                    color: color.textForHomeScreen,
                                  )),
                            ),
                          ])),
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
                        color: const Color.fromARGB(255, 233, 7, 7),
                        border: Border.all(
                            color: const Color(0xFFEDF6FA), width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xFFE8F3FA),
                              offset: Offset(0, 0),
                              blurRadius: 20)
                        ]),
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      // show swap text and direction text
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF607D8B), width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: const Color(0xFF607D8B),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Swap : ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: "Montserrat",
                                )),
                            Text(direction,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: "Montserrat",
                                )),
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
    );*/
  }
}
