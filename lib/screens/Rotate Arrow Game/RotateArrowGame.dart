import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../../main.dart';
import 'package:provider/provider.dart';

class SecondGame extends StatefulWidget {
  const SecondGame({super.key});

  @override
  State<SecondGame> createState() => _SecondGameState();
}

class _SecondGameState extends State<SecondGame> {
  int _secondsRemaining = 30;
  late Timer _timer;

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent; // Set default color
  bool displayFeedback = false;
  late Timer _feedbackTimer =
      Timer(Duration.zero, () {}); // Initialize with an empty timer

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
          // Timer completed
        }
      });
    });
  }

  void _startFeedbackTimer() {
    setState(() {
      displayFeedback = true;
    });

    _feedbackTimer = Timer(const Duration(milliseconds: 1000), () {
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
          content: Text(
            "Your Score : ${score.scoreForAccuracyGame}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                score.restartScoreForAccuracyGames();
                Navigator.of(context).pop();
                // Navigate to the main menu
                // You can replace '/home' with your main menu route
                Navigator.pushNamed(context, '/home');
              },
              child: const Text("Main Menu"),
            ),
            TextButton(
              onPressed: () {
                score.restartScoreForAccuracyGames();
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

  rotateLeft() {
    setState(() {
      userArrowAngle = userArrowAngle - 20;
      if (userArrowAngle < 0) {
        userArrowAngle = 340;
      }
    });
  }

  rotateRight() {
    setState(() {
      userArrowAngle = userArrowAngle + 20;
      if (userArrowAngle > 360) {
        userArrowAngle = 20;
      }
      if (userArrowAngle == 360) {
        userArrowAngle = 0;
      }
    });
  }

  List<double> mainArrowAngles = [
    0,
    20,
    40,
    60,
    80,
    100,
    120,
    140,
    160,
    180,
    200,
    220,
    240,
    260,
    280,
    300,
    320,
    340
  ];
  List<double> userArrowAngles = [
    0,
    20,
    40,
    60,
    80,
    100,
    120,
    140,
    160,
    180,
    200,
    220,
    240,
    260,
    280,
    300,
    320,
    340
  ];

  double mainArrowAngle = 20;
  double userArrowAngle = 60;

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: true);
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);

    checkThedirection() {
      double angleDifference = (mainArrowAngle - userArrowAngle).abs();

      if (angleDifference == 0) {
        setState(() {
          score.addScoreForAccuracyGames();
          feedbackMessage = "Correct +500";
          feedbackColor = Colors.green;
          displayFeedback = true;
        });
      } else if ((angleDifference == 20) || (angleDifference == -20)) {
        // Adjust this threshold as needed
        setState(() {
          score.addScoreForAccuracyGamesClose();
          feedbackMessage = "Close +300";
          feedbackColor = Colors.yellow;
          displayFeedback = true;
        });
      } else {
        setState(() {
          score.minScoreForAccuracyGames();
          feedbackMessage = "Wrong -400";
          feedbackColor = Colors.red;
          displayFeedback = true;
        });
      }

      setState(() {
        mainArrowAngle =
            mainArrowAngles[Random().nextInt(mainArrowAngles.length)];

        userArrowAngle =
            userArrowAngles[Random().nextInt(userArrowAngles.length)];
      });
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        ' Score : ${score.scoreForAccuracyGame}',
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
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border:
                    Border.all(color: color.gamesContainerStroke, width: 0.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFE8F3FA),
                      blurRadius: 2,
                      offset: Offset(0, 0))
                ],
                color: color.gamesContainer,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                      angle: mainArrowAngle * (pi / 180),
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        color: color.rotatearrowgameMainarrow,
                        size: 115,
                      ))
                ],
              ),
            ), // Game's Arrow
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border:
                    Border.all(color: color.gamesContainerStroke, width: 0.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFE8F3FA),
                      blurRadius: 2,
                      offset: Offset(0, 0))
                ],
                color: color.gamesContainer,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.rotate(
                        angle: userArrowAngle * (pi / 180),
                        child: Icon(
                          Icons.arrow_right_alt_rounded,
                          color: color.rotatearrowgameUserarrow,
                          size: 115,
                        ),
                      )
                    ],
                  ), // User's Arrow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          rotateLeft();
                        },
                        color: color
                            .rotatearrowgameRotatebuttons, // Background color
                        textColor: Colors.white, // Text color
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // You can customize the shape of the button here
                        ),
                        child: const Text(
                          'Rotate left',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          rotateRight();
                        },
                        color: color
                            .rotatearrowgameRotatebuttons, // Background color
                        textColor: Colors.white, // Text color
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // You can customize the shape of the button here
                        ),
                        child: const Text(
                          'Rotate right',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          checkThedirection();
                          _startFeedbackTimer();
                        },
                        color: color
                            .rotatearrowgameCheckbutton, // Background color
                        textColor: Colors.white, // Text color
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // You can customize the shape of the button here
                        ),
                        child: const Text(
                          '                 CHECK                 ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
