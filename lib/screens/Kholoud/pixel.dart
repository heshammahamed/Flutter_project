import 'package:flutter/material.dart';

class pixel extends StatelessWidget{
  var color;

  pixel({super.key, required this.color,});

  @override 
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.all(1),
    );
}
}