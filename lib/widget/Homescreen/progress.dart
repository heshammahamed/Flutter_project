
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../main.dart';


/*
    How to calculate ??!

    Provider in the Home screen??!

    



 */


/*

  4 games : 

  brightest Color    --> observation (Cat)  done
  rotate             --> Accuracy    (Cat)  done
  Color Matching     --> observation (Cat)  done
  Directions         --> observation (Cat)  done
  biggest number     --> Mathimatics (Cat)  



 */

/* 

  percent 0.0 -> 1.0

  - for each game it will increase 0.1 for 1000 point

  total percent 0.0 -> 1.0
  
  - for each 0.5 in any percent the total will increase to 0.1

  so we need to what ????????

  in the class of score we need to 

  1- add score for each game   "that score showen to the user"
      1- increase the score after correct answer.
      2- decress the score after wrong answer.
      3- this score will restart to zero when the game end.

loop (tes , tes = 0.0 , tes-0.1) {
  if (perc != 0.9) ? perc + 0.1 : perc = 0 and call the total fun "to calculate the tota"
}

  2- add percentindicator for each game  "that will showen in the home screen"
    1- after the game is end it will calculate the value  (0.0 , 1.0)  before the score is return to zero.
        1- tes (score / 1000) round it / 100 
        2- if it greater than 1.0  


  3- total percent indicator
    add 0.1 when the function called 
    if the value equal to 1.0 then add +1 to the level and restart the vcalue to start from 0.0



 how it know what the score is for ?????????
by make score for each game

*/




class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {

  @override
  Widget build(BuildContext context) {
    Score score = Provider.of<Score>(context, listen: true);
    return Stack(
      clipBehavior:Clip.none ,
      children: [
      Container (
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFF28292D),
      ),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
    child:  
    Row (
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children : [
        CircularPercentIndicator(
          radius: 130,
          lineWidth: 8,
          percent: score.totalPercent,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text("LV.${score.level}" , style: const TextStyle(fontFamily: 'POP' , color: Colors.white, fontSize: 30),)),

        Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/rubik.png', width:MediaQuery.of(context).size.width * 0.06,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                     Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 ),
                      child: const Text('Observation', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: score.observationLevelPercent,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.brown,

                    )
                  ]
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/maths.png', width:MediaQuery.of(context).size.width * 0.06,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 ),
                      child: const Text('Mathimatics', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: score.mathematicsLevelPercent,
                      progressColor: Colors.yellow,
                      linearStrokeCap: LinearStrokeCap.butt,

                    )
                  ]
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/micro-sd-card.png', width:MediaQuery.of(context).size.width * 0.07,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 ),
                      child: const Text('Memory', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.4,
                      progressColor: Colors.blue,
                      linearStrokeCap: LinearStrokeCap.butt,

                    )
                  ]
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/accuracy.png', width:MediaQuery.of(context).size.width * 0.06,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 ),
                      child: const Text('Accuracy', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: score.accuracyLevelPercent,
                      progressColor: Colors.white,
                      linearStrokeCap: LinearStrokeCap.butt,

                    )
                  ]
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/critical-thinking.png', width:MediaQuery.of(context).size.width * 0.08,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 ),
                      child: const Text('Logic', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.4,
                      progressColor: Colors.greenAccent,
                      linearStrokeCap: LinearStrokeCap.butt,

                    )
                  ]
                )
              ],
            ),
          ],

        )
      ], 

      
    )),
      Positioned(top: -35,left: 20,child: Image.asset('assets/images/rising.png' , width:MediaQuery.of(context).size.width * 0.14)),
      ],
    );
  }
}