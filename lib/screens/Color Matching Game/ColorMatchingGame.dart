import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

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
  int score = 0;
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

  changeState() {
    setState(() {
      meaining = colors[Random().nextInt(4)];
      text = colors[Random().nextInt(4)];
      textColor = textColors[i];
      textColorString = colors[i];
    });
  }

  trueCheckScore() {
    if (meaining == textColorString) {
      setState(() {
        score = score + 500;
        feedbackMessage = "Correct +500";
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
    changeDirectionOfArrow();
    changeState();
  }

  falseCheckScore() {
    if (meaining != textColorString) {
      setState(() {
        score = score + 500;
        feedbackMessage = "Correct +500";
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
    changeDirectionOfArrow();
    changeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF161616),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // timer section
                  Container(
                      child: Text("Timer : $_secondsRemaining",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25))),

                  // score section
                  Container(
                      child: Text("Score : ${score}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25)))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              Container(
                  child: Column(
                children: [
                  const Text(
                      "Is the meaning at the top the same as the color at the bottom?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 70,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "meaning",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 300,
                        height: 100,
                        alignment: Alignment.center,
                        child: Text(meaining,
                            style: const TextStyle(fontSize: 50)),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 300,
                        height: 100,
                        alignment: Alignment.center,
                        child: Text(text,
                            style: TextStyle(color: textColor, fontSize: 50)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "color",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => trueCheckScore(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(40)),
                              alignment: Alignment.center,
                              width: 150,
                              height: 70,
                              child: const Text(
                                "True",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w400),
                              ))),
                      GestureDetector(
                          onTap: () => falseCheckScore(),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(40)),
                              alignment: Alignment.center,
                              width: 150,
                              height: 70,
                              child: const Text(
                                "False",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w400),
                              ))),
                    ],
                  )
                ],
              ))
            ])));
  }
}
