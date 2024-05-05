import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class SecondGame extends StatefulWidget {
  const SecondGame({super.key});

  @override
  State<SecondGame> createState() => _SecondGameState();
}

class _SecondGameState extends State<SecondGame> {
  int _secondsRemaining = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          // Timer completed
        }
      });
    });
  }

  rotateLeft() {
    setState(() {
      userArrowAngle = userArrowAngle - 10;
    });
  }

  rotateRight() {
    setState(() {
      userArrowAngle = userArrowAngle + 10;
    });
  }

// 1 ==> total point
// (2 , 0.5)

// 20 / 20 == 1  ===> 100
// 20 / 30  == 0.6   (10)
// 20 / 10  == 2   (10)

// 20 / 40  == 0.5  diffrent (20) 0

// [.5 , 1]

  checkThedirection() {
    if (mainArrowAngle / userArrowAngle == 1) {
      setState(() {
        score = score + 100;
      });
    } else if ((mainArrowAngle / userArrowAngle > 0.5) &
        (mainArrowAngle / userArrowAngle < 1)) {
      setState(() {
        score = score + 20;
      });
    } else if ((mainArrowAngle / userArrowAngle > 1) &
        (mainArrowAngle / userArrowAngle < 1.5)) {
      setState(() {
        score = score + 20;
      });
    }

    setState(() {
      mainArrowAngle =
          mainArrowAngles[Random().nextInt(30)]; // 0 , 1 , 2 ,3 , 4 ,5
      userArrowAngle =
          userArrowAngles[Random().nextInt(30)]; // 0 , 1 , 2 ,3 , 4 ,5
    });
  }

  List<double> mainArrowAngles = [
    40,
    120,
    210,
    30,
    320,
    90,
    270,
    160,
    350,
    50,
    190,
    20,
    310,
    250,
    110,
    60,
    180,
    290,
    140,
    230,
    80,
    170,
    330,
    200,
    70,
    280,
    130,
    10,
    240,
    100
  ];
  List<double> userArrowAngles = [
    40,
    120,
    210,
    30,
    320,
    90,
    270,
    160,
    350,
    50,
    190,
    20,
    310,
    250,
    110,
    60,
    180,
    290,
    140,
    230,
    80,
    170,
    330,
    200,
    70,
    280,
    130,
    10,
    240,
    100
  ];

  double mainArrowAngle = 20;
  double userArrowAngle = 50;
  int score = 0;

  @override
  Widget build(BuildContext context) {
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
                        ' Score : $score',
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
              height: 20,
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
              child: Column(
                children: [
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          checkThedirection();
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
                          'Check the direction',
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
