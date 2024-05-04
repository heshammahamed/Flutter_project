import 'package:flutter/material.dart';


class MohamedGame extends StatefulWidget {
  const MohamedGame({super.key});

  @override
  State<MohamedGame> createState() => _MohamedGameState();
}

class _MohamedGameState extends State<MohamedGame> {


List mainColors = [Colors.red[500] , Colors.blue[500] , Colors.purple[500]];
List brightestColors = [Colors.red[400] , Colors.blue[400] , Colors.purple[400]];

var mainColor = Colors.red[500];
var brightestColor = Colors.red[400];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Timer : 2                 Score : 100",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 500,
          height: 700,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10)), //علشان اعمل حواف دائريه للكونتينر
            border: Border.all(color: Colors.black, width: 5), //البرواز الخارجى
          ),
          child:
          
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),

  itemCount: 9, // Total number of items in the grid
  itemBuilder: (BuildContext context, int index) {
    // This function is called for every item in the grid
    // It returns the widget to display for each item
    return Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          width: 111,
          height: 370,
        );
  },
),
      ),
    ));
  }
}





