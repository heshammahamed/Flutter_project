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
    score = score + 500;
    notifyListeners();
  }

  minOne () {
    score < 0 ? score = score - 1000 : score = 0;
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
            const Head(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.09),
            const BodyOfTheGAme()
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

 int _secondsRemaining = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          // Timer completed
        }
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {



    return Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        // timer section
        Container(
          child: Text ("Timer : $_secondsRemaining" , style: const TextStyle(color: Colors.white , fontSize: 25))
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
                Text(meaining , style: const TextStyle(fontSize: 50)),
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
              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),

                width: 150,
                height: 50,
                alignment: Alignment.center,
                child : const Text("color" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              ),
            ],
          ),

          const SizedBox(height: 45),

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

                child: const Text("False" , style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w400),)
              )),
            ],
          )
        ],
      )
    );
  }
}