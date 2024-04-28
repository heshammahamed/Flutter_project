import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

/*class SecondGame extends StatelessWidget {
  const SecondGame({super.key});

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
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white),
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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                        Text(
                          '  Timer :      ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color.fromARGB(221, 26, 26, 26)),
                        )
                      ],
                    )),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.leaderboard,
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                        Text(
                          '  Progress :      ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color.fromARGB(221, 26, 26, 26)),
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/right_arrow.png',
                  width: 100,
                  height: 100,
                )
              ],
            ), // صورة السهم اللي المفروض تقلده
            const SizedBox(
              height: 55,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: Color.fromARGB(221, 26, 26, 26),
                  size: 100,
                )
              ],
            ), // السهم اللي اليوزر هيحركه
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {},
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
                    onPressed: () {},
                    color: Colors.indigo, // Background color
                    textColor: Colors.white, // Text color
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    onPressed: () {},
                    color: Colors.green[800], // Background color
                    textColor: Colors.white, // Text color
                    elevation: 10,
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
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}*/

class SecondGame extends StatefulWidget {
  const SecondGame({super.key});

  @override
  State<SecondGame> createState() => _SecondGameState();
}

class _SecondGameState extends State<SecondGame> {
  int RemainingSeconds = 60;
  void Countdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (RemainingSeconds != 0) {
        setState(() {
          RemainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void A_Rotate() {}

  @override
  Widget build(BuildContext context) {
    Countdown();
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
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white),
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
                          '  Timer : $RemainingSeconds',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color.fromARGB(221, 26, 26, 26)),
                        )
                      ],
                    )),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.leaderboard,
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                        Text(
                          '  Progress :    ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Color.fromARGB(221, 26, 26, 26)),
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/right_arrow.png',
                  width: 100,
                  height: 100,
                )
              ],
            ), // صورة السهم اللي المفروض تقلده
            const SizedBox(
              height: 55,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: Color.fromARGB(221, 26, 26, 26),
                  size: 100,
                )
              ],
            ), // السهم اللي اليوزر هيحركه
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {},
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
                    onPressed: () {},
                    color: Colors.indigo, // Background color
                    textColor: Colors.white, // Text color
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
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
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    onPressed: () {},
                    color: Colors.green[800], // Background color
                    textColor: Colors.white, // Text color
                    elevation: 10,
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
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
