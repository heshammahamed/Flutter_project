import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../main.dart';

class FirstGame extends StatefulWidget {
  const FirstGame({super.key});

  @override
  State<FirstGame> createState() => _FirstGameState();
}

class _FirstGameState extends State<FirstGame> {
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
    "13",
    "7 + 8",
    "100 - 20",
    "50 * 2",
    "40 / 5",
    "6 * 6",
    "144 / 12",
    "11 + 11",
    "10 - 1",
    "8 * 3",
    "81 / 9",
    "2^5",
    "sqrt(64)",
    "7 * 13",
    "150 / 3",
    "98 + 45",
    "120 - 15",
    "11^2",
    "sqrt(169)",
    "56 * 4",
    "800 / 25"
  ];

  List<int> numbers1 = [
    9,
    12,
    19,
    9 * 9,
    20 ~/ 3,
    134,
    5 + 10,
    999,
    23,
    13,
    7 + 8,
    100 - 20,
    50 * 2,
    40 ~/ 5,
    6 * 6,
    144 ~/ 12,
    11 + 11,
    10 - 1,
    8 * 3,
    81 ~/ 9,
    pow(2, 5).toInt(),
    sqrt(64).toInt(),
    7 * 13,
    150 ~/ 3,
    98 + 45,
    120 - 15,
    pow(11, 2).toInt(),
    sqrt(169).toInt(),
    56 * 4,
    800 ~/ 25
  ];

  List<int> numbers2 = [
    6,
    21,
    16,
    81,
    20 ~/ 2,
    143,
    20 - 10,
    969,
    32,
    13,
    14,
    80,
    100,
    8,
    36,
    12,
    22,
    9,
    24,
    9,
    pow(3, 4).toInt(),
    sqrt(49).toInt(),
    9 * 8,
    200 ~/ 5,
    76 + 89,
    110 - 25,
    pow(13, 2).toInt(),
    sqrt(225).toInt(),
    63 * 3,
    900 ~/ 30
  ];

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
    "13",
    "14",
    "80",
    "100",
    "8",
    "36",
    "12",
    "22",
    "9",
    "24",
    "9",
    "3^4",
    "sqrt(49)",
    "9 * 8",
    "200 / 5",
    "76 + 89",
    "110 - 25",
    "13^2",
    "sqrt(225)",
    "63 * 3",
    "900 / 30"
  ];

  int first = 0;
  int seco = 0;

  String num1 = "9";
  String num2 = "6";

  changeState() {
    setState(() {
      first = Random().nextInt(numbers1.length);
      seco = Random().nextInt(numbers2.length);
      num1 = numbersAsString1[first];
      num2 = numbersAsString2[seco];
    });
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
          content: Text("Your Score : ${score.scoreForMathematicsGame}"),
          actions: [
            TextButton(
              onPressed: () {
                score.restartScoreForMathematicsGames();
                Navigator.of(context).pop();
                // Navigate to the main menu
                // You can replace '/home' with your main menu route
                Navigator.pushNamed(context, '/home');
              },
              child: const Text("Main Menu"),
            ),
            TextButton(
              onPressed: () {
                score.restartScoreForMathematicsGames();
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

    equalBoxCheckScore() {
      if (numbers2[seco] == numbers1[first]) {
        setState(() {
          score.addScoreForMathematicsGameGames();
          feedbackMessage = "Correct +500";
          feedbackColor = Colors.green;
          displayFeedback = true;
        });
      } else {
        setState(() {
          score.minScoreForMathematicsGames();
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
          score.addScoreForMathematicsGameGames();
          feedbackMessage = "Correct +500";
          feedbackColor = Colors.green;
          displayFeedback = true;
        });
      } else {
        setState(() {
          score.minScoreForMathematicsGames();
          feedbackMessage = "Wrong -400";
          feedbackColor = Colors.red;
          displayFeedback = true;
        });
      }
      changeState();
    }

    firstBoxCheckScore() {
      if (numbers1[first] > numbers2[seco]) {
        setState(() {
          score.addScoreForMathematicsGameGames();
          feedbackMessage = "Correct +500";
          feedbackColor = Colors.green;
          displayFeedback = true;
        });
      } else {
        setState(() {
          score.minScoreForMathematicsGames();
          feedbackMessage = "Wrong -400";
          feedbackColor = Colors.red;
          displayFeedback = true;
        });
      }
      changeState();
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
                'Biggest Number Game',
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: color.textForHomeScreen, width: .5),
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
                                color: color.textForHomeScreen, width: .5),
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
                              ' Score : ${score.scoreForMathematicsGame}',
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
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: color.gamesContainerStroke,
                          width: MediaQuery.of(context).size.width * .01),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFFE8F3FA),
                            blurRadius: 2,
                            offset: Offset(0, 0))
                      ],
                      color: color.gamesContainer, // the full column color
                      shape: BoxShape.rectangle,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Choose The Biggest Number",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: "Montserrat",
                            color: color.textForHomeScreen,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Visibility(
                            visible: displayFeedback,
                            child: Text(
                              feedbackMessage,
                              style:
                                  TextStyle(fontSize: 20, color: feedbackColor),
                            ),
                          ), // Display feedback only when required,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: color.gamesContainerStroke,
                            ),
                            color: color.biggestnumbersNumbers,
                            shape: BoxShape.rectangle,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: MaterialButton(
                            onPressed: () {
                              firstBoxCheckScore();
                              _startFeedbackTimer();
                            },
                            textColor: color.textForHomeScreen, // Text color
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                num1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: "Montserrat",
                                  color: color.textForHomeScreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: color.gamesContainerStroke,
                            ),
                            color: color.biggestnumbersNumbers,
                            shape: BoxShape.rectangle,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: MaterialButton(
                            onPressed: () {
                              secondBoxCheckScore();
                              _startFeedbackTimer();
                            },
                            textColor: color.textForHomeScreen, // Text color
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                num2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: "Montserrat",
                                  color: color.textForHomeScreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            shape: BoxShape.rectangle,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: MaterialButton(
                            onPressed: () {
                              equalBoxCheckScore();
                              _startFeedbackTimer();
                            },
                            color: color
                                .biggestnumbergameEqualbutton, // Background color
                            textColor: Colors.white, // Text color
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              // You can customize the shape of the button here
                            ),
                            child: const Center(
                              child: Text(
                                'Equal',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ])));
  }
}
