import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

void CreateNewpiece(){
  Random rand = Random();

  Tetromino randomtype =
  Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentpiece = piece(type: randomtype);
  currentpiece.intializepiece();
}


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
    return false; }


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



void gameloop(Duration frameRate)
{
  Timer.periodic(frameRate,
   (timer) {
    setState(() {
      checkLanding();
      currentpiece.movepiece(Direction.down);
    });
    });
}
void moveleft(){
  if(!checkcollision(Direction.left)){
    setState(() {
      currentpiece.movepiece(Direction.left);
    });
  }
}

void moveright(){
  if(!checkcollision(Direction.right)){
    setState(() {
      currentpiece.movepiece(Direction.right);
    });
  }
}

void rotatepiece(){
  setState(() {
    currentpiece.rotatepiece();
  });
}


  @override
  Widget build(BuildContext context){
    return Scaffold( 
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowlength*collength,
              physics: const NeverScrollableScrollPhysics(),
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowlength),
             itemBuilder: (context, index){
            
                int row = (index /rowlength).floor();
                int col = index % rowlength;
            
              if(currentpiece.position.contains(index)){
                 return pixel(
               color: currentpiece.color,
               child: index,
              );
              }
              
              else if(gameboard[row][col] != null){
                final Tetromino? tetrominotype = gameboard[row][col];
                return pixel(color: tetrominoColors[tetrominotype], child: '');
              }
              
              
              else{
              return pixel(
               color: Colors.grey[900],
               child: index,
              );}
            },
                ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              IconButton(onPressed: moveleft,color: Colors.white,
               icon: Icon(Icons.arrow_back_ios)),
            
              IconButton(onPressed: rotatepiece, color: Colors.white,
               icon: Icon(Icons.rotate_right)),
            
              IconButton(onPressed: moveright, color: Colors.white,
               icon: Icon(Icons.arrow_forward_ios)),   
            ],),
          )

        ],
      ),
  );
}
}
