import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'timer.dart';

class SameColorInstructions extends StatefulWidget {
  const SameColorInstructions({super.key});

  @override
  State<SameColorInstructions> createState() => _SameColorInstructionsState();
}

class _SameColorInstructionsState extends State<SameColorInstructions> {
  @override
  Widget build(BuildContext context) {
      DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: color.textForHomeScreen, width: 0.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ]),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Text(
                        '       Game Instructions       ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 9,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Text(
                        '-  There will be two text showen on the screen.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                        '-  If the top text is the second text color then press true button.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                        '-  If the top text is not the second text color then press false button.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                        '-  You will get + 500 if you swap in the correct direction.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                        '-  You will get - 400 if you swap in the wrong direction.',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: color.textForHomeScreen,
                        )),
                  ],
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
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
                    '              Play              ',
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
