import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  // delay before loading the home screen

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Homescreen()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF161616),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.brain,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(height: 50),
            Text(
              "MiniGames",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
