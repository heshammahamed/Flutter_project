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

 int currentscore =0;
 bool gameover = false;

  @override
  void initstate(){
    super.initState();
    startgame();
  }
  void startgame(){
    currentpiece.intializepiece();
    Duration frameRate = const Duration(milliseconds: 500);
    gameloop(frameRate);
  }

void CreateNewpiece(){
  Random rand = Random();

  Tetromino randomtype =
  Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentpiece = piece(type: randomtype);
  currentpiece.intializepiece();

  if(isgameover()){
    gameover = true;
  }
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
    if(mounted) {
      setState(() {
      clearlines();
      checkLanding();
      if(gameover == true){
        timer.cancel();
        showgameoverdialog();
      }
      currentpiece.movepiece(Direction.down);
    });
    }
    });
}

void showgameoverdialog(){
  showDialog(
    context: context,
     builder: (context) => AlertDialog(
      title: Text('Game Over'),
      content: Text("Your Score is: $currentscore"),
      actions: [
        TextButton(
          onPressed: (){
            resetgame();
            Navigator.pop(context);
          }, 
          child: Text('Play Again'))
      ],
     ));
}


void resetgame(){
  gameboard = List.generate(
    collength,
    (i) => List.generate(
    rowlength,
    (j) => null,
  ),
  );

gameover =false;
currentscore = 0;
CreateNewpiece();
startgame();

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


void clearlines(){
  for(int row = collength-1; row >= 0; row--){
    bool rowisfull =true;
     
     for(int col = 0; col< rowlength; col++){
      if(gameboard[row][col] == null){
        rowisfull = false;
        break;
      }
     }

     if(rowisfull){
      for(int r = row; r>0; r--){
        gameboard[r] = List.from(gameboard[r-1]);
      }

      gameboard[0] = List.generate(row, (index) => null);

      currentscore++;
     }
  }
}

bool isgameover(){
  for(int col = 0; col< rowlength; col++){
    if(gameboard[0][col] != null){
      return true;
    }
  }
  return false;
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

              );
              }
              
              else if(gameboard[row][col] != null){
                final Tetromino? tetrominotype = gameboard[row][col];
                return pixel(color: tetrominoColors[tetrominotype],);
              }
              
              
              else{
              return pixel(
               color: Colors.grey[900],

              );}
            },
                ),
          ),


          Text(
            'Score: $currentscore',
            style: TextStyle(color: Colors.white),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              IconButton(onPressed: startgame,color: Colors.white,
               icon: Icon(Icons.circle)),
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
