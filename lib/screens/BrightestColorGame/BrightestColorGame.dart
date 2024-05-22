import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math';
import '../../main.dart';

class MohamedGame extends StatefulWidget {
  const MohamedGame({super.key});

  @override
  State<MohamedGame> createState() => _MohamedGameState();
}

class _MohamedGameState extends State<MohamedGame> {
  // list of colors
  List mainColors = [
    Colors.red[500],
    Colors.blue[500],
    Colors.amber[500],
    Colors.brown[500],
    Colors.green[500],
    Colors.lightGreen[500],
    Colors.purple[500],
    Colors.teal[500],
    Colors.pink[500]
  ];
  List brightestColors = [
    Colors.red[400],
    Colors.blue[400],
    Colors.amber[400],
    Colors.brown[400],
    Colors.green[400],
    Colors.lightGreen[400],
    Colors.purple[400],
    Colors.teal[400],
    Colors.pink[400]
  ];

  Color mainColor = Colors.red[500]!; // Main color
  Color brightestColor = Colors.red[400]!; // Brightest Color

  // Brightest Color Place
  int differentColorIndex = 0;

  // loop on the colrs list
  int i = 0;

  int _secondsRemaining = 30; // Time in Seconds
  late Timer _timer; // Timer
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
                score.restartScoreForObservationGames(); // Reset Score
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

  changeColor() {
    (i == mainColors.length - 1) ? i = 0 : i++;
    setState(() {
      mainColor = mainColors[i];
      brightestColor = brightestColors[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: true);
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: color.gamesAppbar,
          title: const Text(
            'Brightest Color Game',
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
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  child: Row(children: [
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
                  ])),
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            "Choose the brightest Color !",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontFamily: "Montserrat",
              color: color.textForHomeScreen,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                right: 10,
                left: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 500,
              height: 550,
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                ),

                itemCount: 12, // Total number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  // Determine where the different color appears
                  if (index == differentColorIndex) {
                    return GestureDetector(
                      onTap: () {
                        // When user press on the differet color
                        feedbackMessage = "Correct +500";
                        feedbackColor = Colors.green;
                        setState(() {
                          _startFeedbackTimer();
                          // Update score
                          score.addScoreForObservationGames();
                          // change the colors
                          changeColor();
                          // Generate a random index to select a new location for the different color
                          differentColorIndex = Random().nextInt(9);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: brightestColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                        ),
                        width: 111,
                        height: 370,
                      ),
                    );
                  } else {
                    // This function is called for every item in the grid
                    // It returns the widget to display for each item
                    return GestureDetector(
                      onTap: () {
                        // When user press on the other main colors
                        setState(() {
                          feedbackMessage = "Wrong -400";
                          feedbackColor = Colors.red;
                          _startFeedbackTimer();
                          // Update score
                          score.minScoreForObservationGames();
                          changeColor();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                        ),
                        width: 111,
                        height: 370,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ]));
  }
}
