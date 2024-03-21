import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../var.dart';


class Head extends StatefulWidget {
  const Head({super.key});

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FaIcon(FontAwesomeIcons.brain,color: Colors.white,size: 30.0,),


          const Text("MiniGames",
          style: TextStyle(fontFamily: 'POP', fontWeight: FontWeight.bold , color: Colors.white, fontSize: 35),),

          IconButton(onPressed: () {
            if (homescreen == const Color(0xFF161616)){
              setState(() {
              homescreen =  Colors.white;
              textcolor = const Color(0xFF161616);
              });
            }else {
              setState(() {
              homescreen =  const Color(0xFF161616);
              textcolor = Colors.white;                
              });

            }
          }, icon: const FaIcon(FontAwesomeIcons.lightbulb,color: Colors.white,size: 30.0,)),

          ]
    );
  }
}