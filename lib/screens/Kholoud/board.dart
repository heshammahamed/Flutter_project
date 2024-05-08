import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_project/screens/Kholoud/pixel.dart';
import 'package:game_project/screens/Kholoud/piece.dart';
import 'package:game_project/screens/Kholoud/values.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  collength,
  (i) => List.generate(
    rowlength,
    (j) => null,
  ),
  );



class GameBoard extends StatefulWidget{
  const GameBoard({super.key});

  @override 
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard>{

  piece currentpiece = piece(type: Tetromino.L);

 bool gameover = false;

  @override
  void initstate(){
    super.initState();
    startgame();
  }
  void startgame(){
    currentpiece.intializepiece();

    Duration frameRate = const Duration(milliseconds: 200);
    gameloop(frameRate);
  }

void gameloop(Duration frameRate)
{
  if(mounted) {
    Timer.periodic(
    frameRate,
   (timer) {
      setState(() {
      clearlines();
      checkLanding();
      if(gameover == true){
        timer.cancel();
        showgameoverdialog();
      }
      currentpiece.movepiece(Direction.down);
    });
},
);
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
      if(row >= 0 && col >= 0){
        if(gameBoard[row][col] != null){
          return true;
        }
      }
    }
    return false;
}



void checkLanding(){
  if(checkcollision(Direction.down)){
    for(int i=0; i < currentpiece.position.length; i++){
     int row = (currentpiece.position[i]/rowlength).floor();
     int col = currentpiece.position[i] % rowlength;
     if(row >= 0 && col >= 0)
     gameBoard[row][col] = currentpiece.type;
    }
    CreateNewpiece();
  }
}

void CreateNewpiece(){
  Random rand = Random();

  Tetromino randomtype =
  Tetromino.values[rand.nextInt(Tetromino.values.length)];
  currentpiece = piece(type: randomtype);
  currentpiece.intializepiece();
  if(isgameover()){
    gameover = true;
  }}

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
  Score score = Provider.of<Score>(context, listen: false);
  for(int row = collength - 1 ; row >= 0; row--){
    bool rowisfull =true;
     
     for(int col = 0; col< rowlength; col++){
      if(gameBoard[row][col] == null){
        rowisfull = false;
        break;
      }
     }

     if(rowisfull){
      for(int r = row; r > 0; r--){
        gameBoard[r] = List.from(gameBoard[r - 1]);
      }

      gameBoard[0] = List.generate(row, (index) => null);
        score.addScoreForLogicGameGames();
     }
  }
}

bool isgameover(){
  for(int col = 0; col< rowlength; col++){
    if(gameBoard[0][col] != null){
      return true;
    }
  }
  return false;
}


void showgameoverdialog(){
    Score score = Provider.of<Score>(context, listen: false);
  showDialog(
    context: context,
     builder: (context) => AlertDialog(
      title: Text('Game Over'),
      content: Text("Your Score is: ${score.scoreForLogicGame}"),
      actions: [
        TextButton(
          onPressed: (){
            resetgame();
            Navigator.pop(context);
          }, 
          child: Text('Play Again')),
        TextButton(
          onPressed: (){
            resetgame();
            Navigator.pushNamed(context , '/');
          }, 
          child: const Text('Main Menu'))
      ],
     ));
}


void resetgame(){
  Score score = Provider.of<Score>(context, listen: false);
  gameBoard = List.generate(
    collength,
    (i) => List.generate(
    rowlength,
    (j) => null,
  ),
  );

  gameover =false;
  score.restartScoreForLogicGames();
  CreateNewpiece();
}

  @override
  Widget build(BuildContext context){
    Score score = Provider.of<Score>(context, listen: false);
    return Scaffold( 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black45,
        scrolledUnderElevation: 50,
        elevation: 10,
        centerTitle: true,
        backgroundColor: const Color(0xFF1976D2),
        title: const Text(
          'Tetris Game',
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: Column(
        children: [

          Container(
            height: 560,
            width: 500,
            padding : EdgeInsets.only(top: 10), 
            margin: EdgeInsets.only(bottom : 5 , top : 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color(0xFFEDF6FA), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFE8F3FA),
                    offset: Offset(0, 0),
                    blurRadius: 20)
              ]),
              child: GridView.builder(
                itemCount: rowlength * collength,
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
                
                else if(gameBoard[row][col] != null){
                  final Tetromino? tetrominotype = gameBoard[row][col];
                  return pixel(color: tetrominoColors[tetrominotype],);
                }
                
                
                else{
                return pixel(
                 color: Colors.grey[900],
              
                );}
              },
                  ),
            ),
          Container(
            padding : EdgeInsets.only(top : 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color(0xFFEDF6FA), width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFE8F3FA),
                    offset: Offset(0, 0),
                    blurRadius: 20)
              ]),
            child:
            Column(
              children: [

             Text(
              'Score: ${score.scoreForLogicGame}',
              style: const TextStyle(fontFamily: "Montserrat",fontSize: 25, fontWeight: FontWeight.bold,letterSpacing: 1.2,color: Colors.black,),
            ),


            Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              GestureDetector(
                  onTap: () => startgame(),

                  child : Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text ("START!!" , style : TextStyle(color :Colors.white)))
                ),

              IconButton(onPressed: moveleft,color: Colors.black,
               icon: Icon(Icons.arrow_back_ios)),
            
              IconButton(onPressed: rotatepiece, color: Colors.black,
               icon: Icon(Icons.rotate_right)),
            
              IconButton(onPressed: moveright, color: Colors.black,
               icon: Icon(Icons.arrow_forward_ios)),   
            ],
            ),
          )
              ],
            )

          ),

        ],
      ),
  );
}
}
