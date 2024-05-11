import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'dart:async';
import '../../main.dart';
import 'package:provider/provider.dart';

/*
Score
Game Timer
Feedback Timer
Game Logic
Popup
*/

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
                Navigator.pushNamed(context, '/');
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

// 1 ==> total point
// (2 , 0.5)

// 20 / 20 == 1  ===> 100
// 20 / 30  == 0.6   (10)
// 20 / 10  == 2   (10)

// 20 / 40  == 0.5  diffrent (20) 0

// [.5 , 1]

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
        mainArrowAngle = mainArrowAngles[
            Random().nextInt(mainArrowAngles.length)]; // 0 , 1 , 2 ,3 , 4 ,5

        userArrowAngle = userArrowAngles[
            Random().nextInt(userArrowAngles.length)]; // 0 , 1 , 2 ,3 , 4 ,5
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: const Color(0xFF1976D2),
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
        backgroundColor: const Color(0xFFF7F8FA),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black, width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ]),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Color.fromARGB(221, 26, 26, 26),
                      ),
                      Text(
                        ' Timer : $_secondsRemaining',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontFamily: "Montserrat",
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black, width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ]),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.leaderboard,
                        color: Color.fromARGB(221, 26, 26, 26),
                      ),
                      Text(
                        ' Score : ${score.scoreForAccuracyGame}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontFamily: "Montserrat",
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ), // Timer & Score Row
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0xFFEDF6FA), width: 0.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFE8F3FA),
                      blurRadius: 10,
                      offset: Offset(0, 0))
                ],
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                      angle: mainArrowAngle * (pi / 180),
                      child: const Icon(
                        Icons.arrow_right_alt_rounded,
                        color: Color(0xFF1976D2),
                        size: 115,
                      ))
                ],
              ),
            ), // Game's Arrow
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0xFFEDF6FA), width: 0.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFE8F3FA),
                      blurRadius: 10,
                      offset: Offset(0, 0))
                ],
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 357,
              width: 340,
              child: Column(
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
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Color.fromARGB(221, 26, 26, 26),
                          size: 115,
                        ),
                      )
                    ],
                  ), // User's Arrow
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          rotateLeft();
                        },
                        color: const Color(0xFF607D8B), // Background color
                        textColor: Colors.white, // Text color
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // You can customize the shape of the button here
                        ),
                        child: const Text(
                          'Rotate left ',
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
                        color: const Color(0xFF607D8B), // Background color
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          checkThedirection();
                          // Start the feedback timer when the main timer starts
                          _startFeedbackTimer();
                        },
                        color: const Color.fromARGB(
                            255, 0, 149, 5), // Background color
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


/*
Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: const Color(0xFFEDF6FA), width: 0.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFE8F3FA),
                      blurRadius: 10,
                      offset: Offset(0, 0))
                ],
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: 
              )
*/