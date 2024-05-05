

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class FirstGame extends StatelessWidget {
  const FirstGame({super.key});

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


  List<String> numbersAsString1 = [ "9" , "12" , "19", "9 * 9", "20 / 3", "134" , "5 + 10"  , "999" , "23", "13"];
  List<int> numbers1 = [ 9 , 12 , 19, 9 * 9, 20 ~/ 3, 134 , 5 + 10  , 999 , 23, 13];
  List<int> numbers2 = [ 6 , 21 , 16,  81,   20 ~/ 2, 143 , 20 - 10 , 969 , 32, 13];
  List<String> numbersAsString2 = [ "6" , "21" , "16",  "81",   "20 / 2", "143" , "20 - 10" , "969" , "32", "13"];

  int first = 0;
  int seco = 0;

  String num1 = "9";
  String num2 = "6";



  @override
  Widget build(BuildContext context) {
  var model = Provider.of<Model>(context);

  changeState () {
    if (first != 9) {
      first++;
      seco++;
    }else {
    first = 0;
    seco = 0;
    }

    setState(() {
      num1 = numbersAsString1[first];
      num2 = numbersAsString2[seco];
    });
  }

  firstBoxCheckScore () {
    (numbers1[first] > numbers2[seco]) ? model.addOne() : model.minOne();
    changeState();
  }
  secondBoxCheckScore () {
    (numbers2[seco] > numbers1[first]) ? model.addOne() : model.minOne();
    changeState();
  }
  equalBoxCheckScore () {
    (numbers2[seco] == numbers1[first]) ? model.addOne() : model.minOne();
    changeState();
  }


    return Container (

      child: Column (
        children: [

          const Text("Chosse the biggest number" , style : TextStyle(color: Colors.white , fontSize: 17 , fontWeight: FontWeight.w500)),

          const SizedBox(height: 70,),

          Column (
            children: [
              
              const SizedBox(height: 20),


              GestureDetector(
                onTap:() => firstBoxCheckScore(),
                child: Container (
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                
                  width: 300,
                  height: 100,
                  alignment: Alignment.center,
                  child: 
                  Text(num1 , style: const TextStyle(fontSize: 50 , color : Colors.black)),
                ),
              )
            ],
          ),

          const SizedBox(height: 55),

          Column (
            children: [             

              
              GestureDetector(

                onTap:() => secondBoxCheckScore(),

                child: Container (
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                
                  width: 300,
                  height: 100,
                  alignment: Alignment.center,
                  child: 
                  Text(num2 , style: const TextStyle(color : Colors.black ,fontSize: 50)),
                ),
              ),

            ],
          ),

          SizedBox(height: 150),


          Center (
            child:
            
              GestureDetector(

                onTap:() => equalBoxCheckScore(),

                child : 
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40)
                ),
                alignment: Alignment.center,
                width: 250,
                height: 70,

                child: const Text("equall" , style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w400),)
              )),
          )
          
        ],
      )
    );
  }
}