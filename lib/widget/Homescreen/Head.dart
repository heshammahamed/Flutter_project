import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../var.dart';
import 'package:provider/provider.dart';
import '../../main.dart';


class Head extends StatefulWidget {
  const Head({super.key});

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color = Provider.of<DarkAndLightMode>(context, listen: true);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FaIcon(FontAwesomeIcons.brain,color: color.textForHomeScreen,size: 30.0,),


          Text("MiniGames",
          style: TextStyle(fontFamily: 'POP', fontWeight: FontWeight.bold , color: color.textForHomeScreen, fontSize: 35),),

          IconButton(onPressed: () => color.changeMode(),
          icon: FaIcon(FontAwesomeIcons.lightbulb,color: color.textForHomeScreen,size: 30.0,)),

          ]
    );
  }
}