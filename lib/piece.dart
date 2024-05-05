import 'package:game_project/values.dart';
class piece{
  Tetromino type;
  piece({required this.type});
  
  List<int> position = [];

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
}