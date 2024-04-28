import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';


// features : 

// problems : 
// clean the code and add comments
// the timer show 5 4 2 0 in the UI but print  5 4 3 2 1 0
// add sound win the anser is correct and if it wrong 
// change the UI because its very very bad

class Model extends ChangeNotifier {
  int score = 0;
  addOne () {
    score++;
    notifyListeners();
  }

  minOne () {
    score--;
    notifyListeners();
  }
}

class SameColor extends StatelessWidget {
  const SameColor({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => Model() , child :
    Scaffold(
      backgroundColor: const Color(0xFF161616) ,
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
            BodyOfTheGAme()
          ]
        ) 

      ) 
    ));
  }
}


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



class BodyOfTheGAme extends StatefulWidget {
  const BodyOfTheGAme({super.key});

  @override
  State<BodyOfTheGAme> createState() => _BodyOfTheGAmeState();
}

class _BodyOfTheGAmeState extends State<BodyOfTheGAme> {

  List<String> colors = ["Red" , "Blue" , "Black" , "Purple"];

  String meaining = "Red";
  String text = "Green";

  List textColors = [Colors.red , Colors.blue , Colors.black , Colors.purple];
  var textColor = Colors.red;
  String textColorString = "Red";

  int i = 0;  // used to pick up the same value from the iconDirections list and direction list

  changeDirectionOfArrow (){
    i = Random().nextInt(4);
  }

  @override
  Widget build(BuildContext context) {
  var model = Provider.of<Model>(context);

  changeState () {
    setState(() {
      meaining = colors[Random().nextInt(4)];
      text = colors[Random().nextInt(4)];
      textColor = textColors[i];
      textColorString = colors[i];      
    });
  }

  trueCheckScore () {
    (meaining == textColorString) ? model.addOne() : model.minOne();
    changeDirectionOfArrow();
    changeState();
  }

  falseCheckScore () {
    (meaining != textColorString) ? model.addOne() : model.minOne();
    changeDirectionOfArrow();
    changeState();
  }

    return Container (

      child: Column (
        children: [

          const Text("Is the meaning at the top the same as the color at the bottom?" , style : TextStyle(color: Colors.white , fontSize: 17 , fontWeight: FontWeight.w500)),

          const SizedBox(height: 70,),

          Column (
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),

                width: 150,
                height: 50,
                alignment: Alignment.center,
                child : const Text("meaning" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              ),
              
              const SizedBox(height: 20),
              Container (
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),

                width: 300,
                height: 100,
                alignment: Alignment.center,
                child: 
                Text(meaining , style: TextStyle(fontSize: 50)),
              )
            ],
          ),

          const SizedBox(height: 25),

          Column (
            children: [             

              Container (
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),

                width: 300,
                height: 100,
                alignment: Alignment.center,
                child: 
                Text(text , style: TextStyle(color : textColor ,fontSize: 50)),
              ),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),

                width: 150,
                height: 50,
                alignment: Alignment.center,
                child : Text("color" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              ),
            ],
          ),

          SizedBox(height: 45),

          Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(

                onTap:() => trueCheckScore(),

                child : 
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40)
                ),
                alignment: Alignment.center,
                width: 150,
                height: 70,

                child: const Text("True" , style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w400),)
              )),


              GestureDetector(

                onTap: () => falseCheckScore(),

                child : 
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40)
                ),
                alignment: Alignment.center,
                width: 150,
                height: 70,

                child: Text("False" , style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w400),)
              )),
            ],
          )
        ],
      )
    );
  }
}