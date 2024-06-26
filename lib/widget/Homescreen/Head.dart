import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FaIcon(
            FontAwesomeIcons.brain,
            color: color.textForHomeScreen,
            size: 34,
          ),
          Text(
            "MiniGames",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: color.textForHomeScreen,
                fontSize: 34),
          ),
          IconButton(
              onPressed: () => color.changeMode(),
              icon: FaIcon(
                color.darklightIcon,
                color: color.darklightIconcolor,
                size: 34,
              )),
        ]);
  }
}
