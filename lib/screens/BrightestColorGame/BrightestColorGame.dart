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
  // int score = 0; // عدد النقاط

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

  Color mainColor = Colors.red[500]!; // اللون الأساسي
  Color brightestColor = Colors.red[400]!; // اللون الأساسي المشرق

  // مكان ظهور اللون المختلف
  int differentColorIndex = 0;

  // loop on the colrs list
  int i = 0;

  int _secondsRemaining = 10; // قيمة الوقت بالثواني
  late Timer _timer; // تايمر
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
              child: Text("Main Menu"),
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
              child: Text("Play Again"),
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

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 10,
          centerTitle: true,
          backgroundColor: const Color(0xFF1976D2),
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
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
                  child: Row(children: [
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
                  ])),
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
                      ' Score : ${score.scoreForObservationGame}',
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
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          const Text(
            "Choose the brightest Color!",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                right: 10,
                left: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 500,
              height: 550,
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                ),

                itemCount: 12, // Total number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  // تحديد مكان ظهور اللون المختلف
                  if (index == differentColorIndex) {
                    return GestureDetector(
                      onTap: () {
                        // عندما يضغط المستخدم على اللون المختلف
                        setState(() {
                          // تحديث النقاط
                          score.addScoreForObservationGames();
                          // change the colors
                          changeColor();
                          // توليد رقم عشوائي لتحديد مكان جديد للون المختلف
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
                        // عندما يضغط المستخدم على الألوان الأخرى
                        setState(() {
                          // تحديث النقاط
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
