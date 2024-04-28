import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





// features : 

// problems : 
// clean the code and add comments
// the timer show 5 4 2 0 in the UI but print  5 4 3 2 1 0
// add sound win the anser is correct and if it wrong 
// change the UI because its very very bad



// For change the state of the variables

class Model extends ChangeNotifier {
  int score = 100;
  addOne () {
    score++;
    notifyListeners();
  }

  minOne () {
    score--;
    notifyListeners();
  }
}





// Main wedgit in the screen

class FifthGame extends StatelessWidget {
  const FifthGame({super.key});

    @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => Model() , child :
     Scaffold(
      // back ground color for the screen
      backgroundColor: const Color(0xFF161616),   
      body : 
      
      Container (

        margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 40),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white , width: 5),
        ),


        child: 
        
        Column (
          children: [
            Head(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            BodyOfTheGame(),
          ]
        ) 

      ) ,
    ));
  }
}


// Wedgit display the timer and score

class Head extends StatefulWidget {
  const Head({super.key});

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {

  // the value wich the timer start in

  int timeLeft = 5;

  // the function wich reduce the timeleft value

  void CountDown () {
    Timer.periodic(const Duration (seconds: 1), (timer) {
      
        if (timeLeft != 0) {
          setState(() {
            timeLeft = timeLeft - 1;
          }); 
          print(timeLeft);
        }else {
          timer.cancel();
        };
     });
  }

  
  @override
  Widget build(BuildContext context) {

    CountDown();

    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // timer section
        Container(
          child: Text ("Timer : ${timeLeft}" , style: const TextStyle(color: Colors.white , fontSize: 25))
        ),

        // score section
        Consumer<Model>(builder: (context, model, child) => 
            Container(
                child: Text ("Score : ${model.score}" , style: const TextStyle(color: Colors.white , fontSize: 25))
                )
        ,)
      ],
    );
  }
}



// Wedgit wich display the arrow and the direction text 

class BodyOfTheGame extends StatefulWidget {
  const BodyOfTheGame({super.key});

  @override
  State<BodyOfTheGame> createState() => _BodyOfTheGameState();
}

class _BodyOfTheGameState extends State<BodyOfTheGame> {

final audio = AudioPlayer();

  // variables
  List<String> directionsList = ["Down","Up","Left", "Right"];

  
  String swap = "right";  // wich direction the user swap


  List iconDirections = [FontAwesomeIcons.arrowDown, FontAwesomeIcons.arrowUp , FontAwesomeIcons.arrowLeft, FontAwesomeIcons.arrowRight];
  List arrowColors = [Colors.red, Colors.green, Colors.red, Colors.green, Colors.red];

  String direction = "Right"; // the direction wich display in the screen

  var iconDirection = FontAwesomeIcons.arrowDown;
  String iconDirectionString = "Down";  // arrow direction 
  var arrowColor = Colors.red;

  bool directionSwapped = false;


int i = 0;  // used to pick up the same value from the iconDirections list and direction list

changeDirectionOfArrow (){
  i = Random().nextInt(4);
}

  @override
  Widget build(BuildContext context) {
  var model = Provider.of<Model>(context);

checkSwap() {
  if (!directionSwapped) {
    
    if (arrowColor == Colors.green) {
      if (iconDirectionString == swap) {
        model.addOne();
      }else {
        model.minOne();
      }
    }else {
    if (direction == swap) {
      model.addOne();
    } else {
      model.minOne();
      }
    }

changeDirectionOfArrow();
    setState(() {
      direction = directionsList[Random().nextInt(4)];
      arrowColor = arrowColors[Random().nextInt(5)];
      iconDirection = iconDirections[i];
      iconDirectionString = directionsList[i];
      directionSwapped = true; 
    });
  }
}
    return GestureDetector (

      onVerticalDragUpdate: (details) {
      int sensitivity = 8;

        if (details.delta.dy > sensitivity) {
          swap = "Down";
          directionSwapped = false;
        }

        if (details.delta.dy < -sensitivity) {
          swap = "Up";
          directionSwapped = false;
      }},


      onHorizontalDragUpdate :(details) {
        int sensitivity = 8;

        if (details.delta.dx > sensitivity) {
          swap = "Right";
          directionSwapped = false;
        }
        
        if (details.delta.dx < -sensitivity) {
          swap = "Left";
          directionSwapped = false;
      }},


    onVerticalDragEnd: (details) {
    Timer(const Duration(milliseconds: 200), () {
      checkSwap();
    });
  },
  onHorizontalDragEnd: (details) {
    Timer(const Duration(milliseconds: 200), () {
      checkSwap();
    });
  },

    child: 
    Container (

      decoration: BoxDecoration(
        border: Border.all(color: Colors.red , width: 2),
      ),

      height: MediaQuery.of(context).size.height * 0.6 ,

      padding: const EdgeInsets.symmetric(horizontal: 40),
      
      child: 
      Column (
        children : [

          // show swap text and direction text

          Row (
            children: [
            const Text ("Swap : " , style: TextStyle(color: Colors.yellow , fontSize: 40)),
            Text (direction , style: const TextStyle(color: Colors.white , fontSize: 35)),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.2),

          // show the arrow icon

          Center (child: FaIcon(iconDirection,color: arrowColor,size: 190.0,))
      ]
    )));
  }
}


