import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../main.dart';

// features :

// problems :
// clean the code and add comments
// the timer show 5 4 2 0 in the UI but print  5 4 3 2 1 0
// add sound win the anser is correct and if it wrong
// change the UI because its very very bad

class SameColor extends StatefulWidget {
  const SameColor({super.key});

  @override
  State<SameColor> createState() => _SameColorState();
}

class _SameColorState extends State<SameColor> {
  int _secondsRemaining = 30;
  late Timer _timer;

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent; // Set default color
  bool displayFeedback = false;
  late Timer _feedbackTimer =
      Timer(Duration.zero, () {}); // Initialize with an empty timer

  List<String> colors = ["Red", "Blue", "Black", "Purple"];

  String meaining = "Red";
  String text = "Green";

  List textColors = [Colors.red, Colors.blue, Colors.black, Colors.purple];
  var textColor = Colors.red;
  String textColorString = "Red";

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
                  score.restartScoreForObservationGames(); // Reset Score
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

  changeState() {
    setState(() {
      meaining = colors[Random().nextInt(4)];
      text = colors[Random().nextInt(4)];
      textColor = textColors[i];
      textColorString = colors[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: false);

    trueCheckScore() {
      if (meaining == textColorString) {
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
      changeDirectionOfArrow();
      changeState();
    }

    falseCheckScore() {
      if (meaining != textColorString) {
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
      changeDirectionOfArrow();
      changeState();
    }

    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: const Color(0xFF1976D2),
          title: const Text(
            'Color Matching Game',
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
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF7F8FA), width: 5),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // timer section
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
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
                        Icon(Icons.timer),
                        Container(
                          child: Text("Timer : $_secondsRemaining",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(221, 26, 26, 26),
                              )),
                        )
                      ],
                    ),
                  ),

                  // score section
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      padding: const EdgeInsets.all(5),
                      child: Row(children: [
                        Icon(Icons.leaderboard),
                        Container(
                          child:
                              Text("Score : ${score.scoreForObservationGame}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: "Montserrat",
                                    color: Color.fromARGB(221, 26, 26, 26),
                                  )),
                        ),
                      ])),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                  child: Column(
                children: [
                  const Text(
                      "Is the meaning at the top the same as the color at the bottom?",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Color.fromARGB(221, 26, 26, 26),
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 137, 163, 176),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,
                        child: const Text(
                          "meaning",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.1,
                        alignment: Alignment.center,
                        child: Text(meaining,
                            style: const TextStyle(
                              fontSize: 50,
                              fontFamily: "Montserrat",
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.1,
                        alignment: Alignment.center,
                        child: Text(text,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 50,
                              fontFamily: "Montserrat",
                            )),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 137, 163, 176),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 0),
                                  blurRadius: 20)
                            ]),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,
                        child: const Text(
                          "color",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () => trueCheckScore(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 0),
                                        blurRadius: 20)
                                  ]),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Text(
                                "True",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat",
                                ),
                              ))),
                      GestureDetector(
                          onTap: () => falseCheckScore(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 0),
                                        blurRadius: 20)
                                  ]),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: const Text(
                                "False",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat",
                                ),
                              ))),
                    ],
                  )
                ],
              ))
            ])));
  }
}
