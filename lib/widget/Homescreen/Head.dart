import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Head extends StatelessWidget {
   const Head({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.brain,color: Colors.white,size: 30.0,),

          SizedBox(width: MediaQuery.of(context).size.width * 0.15),

          const Text("MiniGames",
          style: TextStyle(fontFamily: 'POP', fontWeight: FontWeight.bold , color: Colors.white, fontSize: 35),)
          ]
    );
  }
}