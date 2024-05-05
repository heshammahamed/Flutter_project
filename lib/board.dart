import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_project/pixel.dart';
import 'package:game_project/piece.dart';
import 'package:game_project/values.dart';
import 'package:provider/provider.dart';

List<List<Tetromino?>> gameboard = List.generate(
  collength,
  (i) => List.generate(
    rowlength,
    (j) => null,
  ),
  );



class Gameboard extends StatefulWidget{
  const Gameboard({super.key});

  @override 
  State<Gameboard> createState() => _GameboardState();
}

class _GameboardState extends State<Gameboard>{
  piece currentpiece = piece(type: Tetromino.L);

  @override
  void initstate(){
    super.initState();
    startgame();
  }
  void startgame(){
    currentpiece.intializepiece();
    Duration frameRate = const Duration(milliseconds: 800);
    gameloop(frameRate);
  }

void gameloop(Duration frameRate)
{
  Timer.periodic(frameRate,
   (timer) {
    setState(() {
      checkLanding();
      currentpiece.movepiece(Direction.down);
    });
    });

  bool checkcollision(Direction direction){
    int row;
    int col;
    for(int i =0; i < currentpiece.position.length; i++){
      row = (currentpiece.position[i]/rowlength).floor();
      col = currentpiece.position[i]%rowlength;

    if(direction == Direction.left){
      col -= 1; }
    else if(direction == Direction.right){
      col += 1; }
    else if(direction == Direction.down){
      row += 1; }


    if(row >= collength || col < 0 || col >= rowlength){
      return true;}
    }
    return false;
  }
void CreateNewpiece(){
  Random rand = Random();

  Tetromino randomtype =
  Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentpiece = piece(type: randomtype);
  currentpiece.intializepiece();
}
void checkLanding(){
  if(checkcollision(Direction.down)){
    for(int i=0; i < currentpiece.position.length; i++){
     int row = (currentpiece.position[i]/rowlength).floor();
     int col = currentpiece.position[i]%rowlength;
     if(row >= 0 && col >= 0)
     gameboard[row][col] = currentpiece.type;
    }
    CreateNewpiece();
  }
}



  @override
  Widget build(BuildContext context){
    return Scaffold( 
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: rowlength*collength,
        physics: const NeverScrollableScrollPhysics(),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowlength),
       itemBuilder: (context, index){
        if(currentpiece.position.contains(index)){
           return pixel(
         color: Colors.yellow,
         child: index,
        );
        }else{
        return pixel(
         color: Colors.grey[900],
         child: index,
        );}
      },
    ),
  );
}
}
}