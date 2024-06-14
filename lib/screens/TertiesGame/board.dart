import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_project/screens/TertiesGame/pixel.dart';
import 'package:game_project/screens/TertiesGame/piece.dart';
import 'package:game_project/screens/TertiesGame/values.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  collength,
  (i) => List.generate(
    rowlength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentpiece = Piece(type: Tetromino.L);

  bool gameover = false;
  bool gameStarted = false;

  void initstate() {
    super.initState();
    startgame();
  }

  void startgame() {
    resetgame();

    Duration frameRate = const Duration(milliseconds: 600);
    gameloop(frameRate);
  }

  void gameloop(Duration frameRate) {
    if (mounted) {
      Timer.periodic(
        frameRate,
        (timer) {
          setState(() {
            clearlines();
            checkLanding();
            if (gameover == true) {
              timer.cancel();
              showgameoverdialog();
            }
            currentpiece.movepiece(Direction.down);
          });
        },
      );
    }
  }

  bool checkcollision(Direction direction) {
    int row;
    int col;
    for (int i = 0; i < currentpiece.position.length; i++) {
      row = (currentpiece.position[i] / rowlength).floor();
      col = currentpiece.position[i] % rowlength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= collength || col < 0 || col >= rowlength) {
        return true;
      }
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkcollision(Direction.down)) {
      for (int i = 0; i < currentpiece.position.length; i++) {
        int row = (currentpiece.position[i] / rowlength).floor();
        int col = currentpiece.position[i] % rowlength;
        if (row >= 0 && col >= 0) gameBoard[row][col] = currentpiece.type;
      }
      createNewpiece();
    }
  }

  void createNewpiece() {
    Random rand = Random();

    Tetromino randomtype =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentpiece = Piece(type: randomtype);
    currentpiece.intializepiece();
    if (isgameover()) {
      gameover = true;
      // Show game over dialog again if the new piece immediately causes a game over
      // showgameoverdialog();
    }
  }

  void moveleft() {
    if (!checkcollision(Direction.left)) {
      setState(() {
        currentpiece.movepiece(Direction.left);
      });
    }
  }

  void moveright() {
    if (!checkcollision(Direction.right)) {
      setState(() {
        currentpiece.movepiece(Direction.right);
      });
    }
  }

  void rotatepiece() {
    setState(() {
      currentpiece.rotatepiece();
    });
  }

  void clearlines() {
    Score score = Provider.of<Score>(context, listen: false);
    for (int row = collength - 1; row >= 0; row--) {
      bool rowisfull = true;

      for (int col = 0; col < rowlength; col++) {
        if (gameBoard[row][col] == null) {
          rowisfull = false;
          break;
        }
      }

      if (rowisfull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // Clear the top row
        gameBoard[0] = List.generate(rowlength, (index) => null);
        score.addScoreForLogicGameGames();
        // After clearing a row, check the same row again in case multiple rows are cleared
        row++;
      }
    }
  }

  bool isgameover() {
    for (int col = 0; col < rowlength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  void showgameoverdialog() {
    Score score = Provider.of<Score>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text(
            "Your Score : ${score.scoreForLogicGame}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                resetgame();
                score.restartScoreForLogicGames();
                Navigator.of(context).pop();
                // Navigate to the main menu
                // You can replace '/home' with your main menu route
                Navigator.pushNamed(context, '/home');
              },
              child: const Text("Main Menu"),
            ),
            TextButton(
              onPressed: () {
                resetgame();
                score.restartScoreForLogicGames();
                Navigator.of(context).pop();
                // Rebuild the current screen
                // startgame();
                setState(() {
                  gameStarted = false;
                });
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  void resetgame() {
    Score score = Provider.of<Score>(context, listen: false);
    gameBoard = List.generate(
      collength,
      (i) => List.generate(
        rowlength,
        (j) => null,
      ),
    );

    gameover = false;
    score.restartScoreForLogicGames();
    // Reset the gameStarted variable to false to show the start button again
    // setState(() {
    //   gameStarted = false;
    // });
    createNewpiece();
  }

  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    Score score = Provider.of<Score>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.black45,
        scrolledUnderElevation: 50,
        elevation: 10,
        centerTitle: true,
        backgroundColor: color.gamesAppbar,
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
      backgroundColor: color.backgroundForHomeScreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 430,
            width: 500,
            child: GridView.builder(
              itemCount: rowlength * collength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowlength),
              itemBuilder: (context, index) {
                int row = (index / rowlength).floor();
                int col = index % rowlength;
                if (currentpiece.position.contains(index)) {
                  return Pixel(
                    color: currentpiece.color,
                  );
                } else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominotype = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[tetrominotype],
                  );
                } else {
                  return Pixel(
                    color: color.textForHomeScreen,
                  );
                }
              },
            ),
          ),
          Container(
              height: 100,
              decoration: BoxDecoration(
                  color: color.gamesContainerStroke,
                  border:
                      Border.all(color: color.textForHomeScreen, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  boxShadow: [
                    BoxShadow(
                        color: color.gamesContainer,
                        offset: const Offset(0, 0),
                        blurRadius: 20)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Score : ${score.scoreForLogicGame}',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: color.textForHomeScreen,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Show the "Start" button only if the game hasn't started yet
                      if (!gameStarted)
                        GestureDetector(
                          onTap: () {
                            // When "Start" button is pressed, set gameStarted to true
                            setState(() {
                              gameStarted = true;
                            });
                            startgame(); // Start the game
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                "               Start               ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Show the control buttons only if the game has started
                      if (gameStarted)
                        IconButton(
                          onPressed: moveleft,
                          color: color.textForHomeScreen,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      if (gameStarted)
                        IconButton(
                          onPressed: rotatepiece,
                          color: color.textForHomeScreen,
                          icon: const Icon(Icons.rotate_right),
                        ),
                      if (gameStarted)
                        IconButton(
                          onPressed: moveright,
                          color: color.textForHomeScreen,
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
