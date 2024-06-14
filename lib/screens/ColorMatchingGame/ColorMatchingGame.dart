import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../main.dart';

class SameColor extends StatefulWidget {
  const SameColor({super.key});

  @override
  State<SameColor> createState() => _SameColorState();
}

class _SameColorState extends State<SameColor> {
  int _secondsRemaining = 30;
  late Timer _timer;

  String feedbackMessage = "";
  Color feedbackColor = Colors.transparent;
  bool displayFeedback = false;
  late Timer _feedbackTimer =
      Timer(Duration.zero, () {}); // Initialize with an empty timer

  List<String> colors = [
    "Red",
    "Blue",
    "Black",
    "Purple",
    "Yellow",
    "Brown",
    "Green",
    "Teal",
    "Pink"
  ];

  String meaning = "Red";
  String text = "Green";

  List textColors = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.purple,
    Colors.yellow,
    Colors.brown,
    Colors.green,
    Colors.teal,
    Colors.pink
  ];
  Color textColor = Colors.red;
  String textColorString = "Red";

  int i =
      0; // used to pick up the same value from the iconDirections list and direction list

  changeDirectionOfArrow() {
    i = Random().nextInt(textColors.length);
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
      meaning = colors[Random().nextInt(colors.length)];
      text = colors[Random().nextInt(colors.length)];
      textColor = textColors[i];
      textColorString = colors[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: false);
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);

    trueCheckScore() {
      if (meaning == textColorString) {
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
      if (meaning != textColorString) {
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
          automaticallyImplyLeading: false,
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: color.gamesAppbar,
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
        backgroundColor: color.backgroundForHomeScreen,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          // Timer & Score Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: color.textForHomeScreen, width: 0.5),
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
                    border:
                        Border.all(color: color.textForHomeScreen, width: 0.5),
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
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Center(
              child: Text(
                  "Is the meaning at the top the same as the color at the bottom ?",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      color: color.textForHomeScreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 137, 163, 176),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 20)
                ]),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: const Center(
              child: Text(
                "meaning",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 120, 0, 0),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFE8F3FA),
                    blurRadius: 2,
                    offset: Offset(0, 0))
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Text(meaning,
                style: const TextStyle(
                  fontSize: 50,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                )),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 120, 0, 0),
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFE8F3FA),
                    blurRadius: 2,
                    offset: Offset(0, 0))
              ],
            ),
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
          // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 137, 163, 176),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 20)
                ]),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.05,
            alignment: Alignment.center,
            child: const Center(
              child: Text(
                "color",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            // height: MediaQuery.of(context).size.height * 0.09,
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
              GestureDetector(
                  onTap: () {
                    trueCheckScore();
                    _startFeedbackTimer();
                  },
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
                          color: Colors.white,
                        ),
                      ))),
              GestureDetector(
                  onTap: () {
                    falseCheckScore();
                    _startFeedbackTimer();
                  },
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
                          color: Colors.white,
                        ),
                      ))),
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ]));
  }
}
