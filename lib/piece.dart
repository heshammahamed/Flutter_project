import 'package:flutter/material.dart';
import 'package:game_project/board.dart';
import 'package:game_project/values.dart';
class piece{
  Tetromino type;
  piece({required this.type});
  
  List<int> position = [];


Color get color{
  return tetrominoColors[type] ??
    const Color(0xFFFFFFFF);
}


  void intializepiece(){
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
        case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
        case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
        case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
        case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
        case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
        case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }
  void movepiece(Direction direction){
    switch (direction) {
      case Direction.down:
        for(int i=0; i< position.length; i++ ){
          position[i] += rowlength;
    }break;
    case Direction.left:
        for(int i=0; i< position.length; i++ ){
          position[i] -= 1;
    }break;
    case Direction.right:
        for(int i=0; i< position.length; i++ ){
          position[i] += 1;
    }break;
      default:
    }
  }
  int rotationstate = 1;
  void rotatepiece(){
    List<int> newposition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationstate){
          case 0:

          newposition = [
            position[1]- rowlength,
            position[1],
            position[1]+ rowlength,
            position[1]+ rowlength + 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[1]- 1,
            position[1],
            position[1]+ 1,
            position[1]+ rowlength - 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[1] + rowlength,
            position[1],
            position[1] - rowlength,
            position[1] - rowlength - 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[1]- rowlength + 1,
            position[1],
            position[1] + 1,
            position[1] - 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;
      
      case Tetromino.J:
        switch (rotationstate){
          case 0:

          newposition = [
            position[1]- rowlength,
            position[1],
            position[1]+ rowlength,
            position[1]+ rowlength - 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[1]- rowlength -1,
            position[1],
            position[1]- 1,
            position[1]+ 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[1] + rowlength,
            position[1],
            position[1] - rowlength,
            position[1] - rowlength + 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] +rowlength+ 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;

      case Tetromino.I:
        switch (rotationstate){
          case 0:

          newposition = [
            position[1]- 1,
            position[1],
            position[1]+ 1,
            position[1]+ 2,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[1]- rowlength,
            position[1],
            position[1]+ rowlength,
            position[1]+ 2*rowlength,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] - rowlength - 2,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[1]+ rowlength,
            position[1],
            position[1] - rowlength,
            position[1] - 2*rowlength,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;


      case Tetromino.S:
        switch (rotationstate){
          case 0:

          newposition = [
            position[1],
            position[1] + 1,
            position[1]+ rowlength -1,
            position[1]+ rowlength,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[1]- rowlength,
            position[1],
            position[1]+ 1,
            position[1]+ rowlength + 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[1],
            position[1] + 1,
            position[1] + rowlength - 1,
            position[1] + rowlength,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[1]- rowlength,
            position[1],
            position[1]+ 1,
            position[1] + rowlength + 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;

        
      case Tetromino.Z:
        switch (rotationstate){
          case 0:

          newposition = [
            position[0] + rowlength -2,
            position[1],
            position[2]+ rowlength - 1,
            position[3] + 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[0]- rowlength + 2,
            position[1],
            position[2] - rowlength + 1,
            position[3] - 1,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[0] + rowlength - 2,
            position[1],
            position[2] + rowlength - 1,
            position[3] + 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[0]- rowlength + 2,
            position[1],
            position[2] - rowlength + 1,
            position[3] - 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;


      case Tetromino.O:
       
       break;

      case Tetromino.T:
        switch (rotationstate){
          case 0:

          newposition = [
            position[2]- rowlength,
            position[2],
            position[2]+ 1,
            position[2]+ rowlength,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 1:

          newposition = [
            position[1]- 1,
            position[1],
            position[1]+ 1,
            position[1]+ rowlength,
          ];
          if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 2:

          newposition = [
            position[1] - rowlength,
            position[1] - 1,
            position[1],
            position[1] + rowlength,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;

            case 3:

          newposition = [
            position[2]- rowlength ,
            position[2] - 1,
            position[2],
            position[2] + 1,
          ];

           if(piecepositionisvalid(newposition)){
          position = newposition;
           rotationstate = (rotationstate + 1) % 4; 
          }
           break;
        }  
        break;
  }
}

  bool  positionisvalid( int Position){
   int row = (Position / rowlength).floor();
   int col = Position % rowlength;
   if(row < 0 || col < 0 || gameBoard[row][col] != null){
    return false;
   }
   else{
    return true;
   }    
  }

   bool piecepositionisvalid(List<int> pieceposition){
     bool firstcoloccupied = false;
     bool lastcoloccupied = false;

     for(int pos in pieceposition){
      if(!positionisvalid(pos)){
        return false;
      }

      int col = pos % rowlength;
      if(col == 0){
        firstcoloccupied = true;
      }
      if(col == rowlength -1){
        lastcoloccupied = true;
      }
     }
     return !(firstcoloccupied && lastcoloccupied);
   }
}