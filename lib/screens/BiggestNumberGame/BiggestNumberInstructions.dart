import 'package:flutter/material.dart';
import 'timer.dart';

class BiggestNumInstructions extends StatefulWidget {
  const BiggestNumInstructions({super.key});

  @override
  State<BiggestNumInstructions> createState() => _BiggestNumInstructionsState();
}

class _BiggestNumInstructionsState extends State<BiggestNumInstructions> {
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
        backgroundColor: const Color.fromARGB(255, 242, 249, 255),
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
                  child: const Row(
                    children: [
                      Text(
                        '       Game Instructions       ',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Column(
                  children: [
                    Text('-  There will be two numbers showen on the screen.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text('-  You must press on the biggest number box.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        '-  You will get +500 points if you choose the correct answer.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        '-  You will lose -400 points if you choose the wrong answer.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color.fromARGB(221, 26, 26, 26),
                        )),
                  ],
                )),
            const SizedBox(
              height: 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimerGame()),
                    );
                  },
                  color:
                      const Color.fromARGB(255, 0, 149, 5), // Background color
                  textColor: Colors.white, // Text color
                  elevation: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    // You can customize the shape of the button here
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      fontFamily: "Montserrat",
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
