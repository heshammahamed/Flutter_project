import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

double levelpercent = 0.4;

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
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
          percent: levelpercent,
          circularStrokeCap: CircularStrokeCap.round,
          center: const Text("LV.0" , style: TextStyle(fontFamily: 'POP' , color: Colors.white, fontSize: 30),)),

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
                      child: Text('Observation', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.5,
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
                      child: Text('Mathimatics', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.5,
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
                      child: Text('Memory', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.7,
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
                      child: Text('Accuracy', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.9,
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
                      child: Text('Logic', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: Colors.white , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: 0.2,
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