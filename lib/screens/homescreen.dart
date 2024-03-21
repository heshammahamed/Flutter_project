import 'package:flutter/material.dart';
import '../widget/Homescreen/Head.dart';
import '../widget/Homescreen/progress.dart';
import '../widget/Homescreen/catSec.dart';
import '../widget/Homescreen/Games.dart';
import '../../var.dart';

// FaIcon(FontAwesomeIcons.brain,color: Colors.white,size: 25.0,)

class  Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor :homescreen ,

      body: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child:ListView(
        children:  [
         const Head(),
         SizedBox(height: MediaQuery.of(context).size.height * 0.09),
         const Progress(),
         SizedBox(height: MediaQuery.of(context).size.height * 0.06),
         const Catego(),
         SizedBox(height: MediaQuery.of(context).size.height * 0.03),
         const Games()
        ] ,
      ) ,
      ) 
    );
  }
}