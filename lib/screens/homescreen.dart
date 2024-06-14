import 'package:flutter/material.dart';
import '../widget/Homescreen/Head.dart';
import '../widget/Homescreen/progress.dart';
import '../widget/Homescreen/Games.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return Scaffold(
        backgroundColor: color.backgroundForHomeScreen,
        body: Padding(
          padding: const EdgeInsetsDirectional.all(8.0),
          child: ListView(
            children: [
              const Head(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              const Progress(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text("  Games : ",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontFamily: "Montserrat",
                      color: color.textForHomeScreen)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Games()
            ],
          ),
        ));
  }
}
