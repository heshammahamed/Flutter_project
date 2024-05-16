
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../main.dart';



class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  

  @override
  Widget build(BuildContext context) {
      DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    Score score = Provider.of<Score>(context, listen: true);
    return Stack(
      clipBehavior:Clip.none ,
      children: [
      Container (
      decoration:  BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: color.textForHomeScreen, width: 0.5),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 0),
                              blurRadius: 20)
                        ],),
                           
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
          center: Text("LV.${score.level}" , style:  TextStyle(fontFamily: 'POP' , color: color.textForHomeScreen, fontSize: 30),)),

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
                      child:  Text('Observation', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: color.textForHomeScreen , fontSize: 16.0 ,),),
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
                      child:  Text('Mathimatics', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: color.textForHomeScreen , fontSize: 16.0 ,),),
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
                      child:  Text('Memory', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: color.textForHomeScreen , fontSize: 16.0 ,),),
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
                      child:  Text('Accuracy', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: color.textForHomeScreen , fontSize: 16.0 ,),),
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
                      child:  Text('Logic', style: TextStyle(fontFamily: 'POP' , fontWeight: FontWeight.w500 , color: color.textForHomeScreen , fontSize: 16.0 ,),),
                    ),

                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.44 ,
                      lineHeight: 4.0 ,
                      percent: score.logicLevelPercent,
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