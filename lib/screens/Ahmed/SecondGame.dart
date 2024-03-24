import 'package:flutter/material.dart';

class SecondGame extends StatelessWidget {
  const SecondGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161616),
      body : Center (child: Text ("Delete Center widget and start Code !!" , style: TextStyle(fontSize : 15.0 , color: Colors.white , fontFamily: "POP",),),) ,
    );
  }
}