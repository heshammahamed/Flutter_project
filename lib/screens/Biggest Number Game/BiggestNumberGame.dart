import 'package:flutter/material.dart';
import 'dart:async';

class FirstGame extends StatefulWidget {
  const FirstGame({super.key});

  @override
  State<FirstGame> createState() => _FirstGameState();
}

class _FirstGameState extends State<FirstGame> {
  int score = 0;
  int _secondsRemaining = 30;
  late Timer _timer;

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent; // Set default color
  bool displayFeedback = false;
  late Timer _feedbackTimer =
      Timer(Duration.zero, () {}); // Initialize with an empty timer

  List<String> numbersAsString1 = [
    "9",
    "12",
    "19",
    "9 * 9",
    "20 / 3",
    "134",
    "5 + 10",
    "999",
    "23",
    "13"
  ];
  List<int> numbers1 = [9, 12, 19, 9 * 9, 20 ~/ 3, 134, 5 + 10, 999, 23, 13];
  List<int> numbers2 = [6, 21, 16, 81, 20 ~/ 2, 143, 20 - 10, 969, 32, 13];
  List<String> numbersAsString2 = [
    "6",
    "21",
    "16",
    "81",
    "20 / 2",
    "143",
    "20 - 10",
    "969",
    "32",
    "13"
  ];

  int first = 0;
  int seco = 0;

  String num1 = "9";
  String num2 = "6";

  changeState() {
    if (first != 9) {
      first++;
      seco++;
    } else {
      first = 0;
      seco = 0;
    }

    setState(() {
      num1 = numbersAsString1[first];
      num2 = numbersAsString2[seco];
    });
  }

  firstBoxCheckScore() {
    if (numbers1[first] > numbers2[seco]) {
      setState(() {
        score = score + 500;
        feedbackMessage = "Correct +500";
        feedbackColor = Colors.green;
        displayFeedback = true;
      });
    } else {
      setState(() {
        score = score - 400;
        feedbackMessage = "Wrong -400";
        feedbackColor = Colors.red;
        displayFeedback = true;
      });
    }
    changeState();
  }

  secondBoxCheckScore() {
    if (numbers2[seco] > numbers1[first]) {
      setState(() {
        score = score + 500;
        feedbackMessage = "Correct +500";
        feedbackColor = Colors.green;
        displayFeedback = true;
      });
    } else {
      setState(() {
        score = score - 400;
        feedbackMessage = "Wrong -400";
        feedbackColor = Colors.red;
        displayFeedback = true;
      });
    }
    changeState();
  }

  equalBoxCheckScore() {
    if (numbers2[seco] == numbers1[first]) {
      setState(() {
        score = score + 500;
        feedbackMessage = "Correct +500";
        feedbackColor = Colors.green;
        displayFeedback = true;
      });
    } else {
      setState(() {
        score = score - 400;
        feedbackMessage = "Wrong -400";
        feedbackColor = Colors.red;
        displayFeedback = true;
      });
    }
    changeState();
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
                              color: Colors.white, fontSize: 25))),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              Container(
                  child: Column(
                children: [
                  const Text("Chosse the biggest number",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 70),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => firstBoxCheckScore(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 300,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(num1,
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 55),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => secondBoxCheckScore(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 300,
                          height: 100,
                          alignment: Alignment.center,
                          child: Text(num2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 50)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: GestureDetector(
                        onTap: () => equalBoxCheckScore(),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            width: 250,
                            height: 70,
                            child: const Text(
                              "equall",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w400),
                            ))),
                  )
                ],
              ))
            ])));
  }
}
