import 'package:flutter/material.dart';

int rowlength = 10;
int collength = 15;
enum Direction{
  left,
  right,
  down,
}
enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}


const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500),
  Tetromino.J: Color.fromARGB(255, 0, 102, 255),
  Tetromino.I: Color.fromARGB(255, 242, 0, 255),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color(0xFF008000),
  Tetromino.Z: Color(0xFFFF0000),
  Tetromino.T: Color.fromARGB(255, 144, 0, 255),
};