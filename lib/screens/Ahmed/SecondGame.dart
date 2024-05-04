import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  rotateLeft () {
    setState(() {
      userArrowAngle = userArrowAngle - 10;
    });

  }
  rotateRight () {
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

checkThedirection () {

  if (mainArrowAngle / userArrowAngle == 1) {
    setState(() {
        score = score + 100;
    });

  }else if ((mainArrowAngle / userArrowAngle > 0.5) & (mainArrowAngle / userArrowAngle < 1)) {
    setState(() {
          score = score + 20;
    });

  }else if ((mainArrowAngle / userArrowAngle  > 1) & (mainArrowAngle / userArrowAngle < 1.5)) {
    setState(() {
          score = score + 20;
    });
  }



setState(() {
    mainArrowAngle = mainArrowAngles[Random().nextInt(6)];     // 0 , 1 , 2 ,3 , 4 ,5
    userArrowAngle = userArrowAngles[Random().nextInt(6)];     // 0 , 1 , 2 ,3 , 4 ,5
});

}


  List<double> mainArrowAngles = [ 180 , 90 , 0 , 340 , 250 , 100 ];
  List<double> userArrowAngles = [ 180 , 90 , 0 , 340 , 250 , 100 ];

double mainArrowAngle = 20;
double userArrowAngle = 50;
int score = 0 ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigo, // Set primary color for the app
        scaffoldBackgroundColor:
            Colors.grey[200], // Set background color for the scaffold
      ),
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black45,
          scrolledUnderElevation: 50,
          elevation: 50,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 143, 147, 255),
          title: const Text(
            'Rotate Arrow Game',
            style: TextStyle(
              fontFamily: "VictorianD",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 230, 255),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Color.fromARGB(221, 26, 26, 26),
                      ),
                      Text(
                        '  Timer : $_secondsRemaining',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.leaderboard,
                        color: Color.fromARGB(221, 26, 26, 26),
                      ),
                      Text(
                        '  Progress :  $score  ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: mainArrowAngle * (pi / 180),
                  child: Image.asset(
                    'assets/images/right_arrow.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ), // Game's Arrow
            const SizedBox(
              height: 55,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.rotate(
                  angle: userArrowAngle * (pi / 180),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color.fromARGB(221, 26, 26, 26),
                    size: 100,
                  ),
                )
              ],
            ), // User's Arrow
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                   rotateLeft();
                  },

                  color: Colors.indigo, // Background color
                  textColor: Colors.white, // Text color
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                   rotateRight();
                  },
                  color: Colors.indigo, // Background color
                  textColor: Colors.white, // Text color
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    // You can customize the shape of the button here
                  ),
                  child: const Text(
                    'Rotate Right',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
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
                    checkThedirection ();
                  },
                  color: Colors.green[800], // Background color
                  textColor: Colors.white, // Text color
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
