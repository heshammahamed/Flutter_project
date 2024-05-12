import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './screens/homescreen.dart';
import 'screens/BiggestNumberGame/BiggestNumberInstructions.dart';
import 'screens/Rotate Arrow Game/RotateArrowInstructions.dart';
import 'screens/BrightestColorGame/BrightestColorInstructions.dart';
import 'screens/DirectionsGame/DirectionInstructions.dart';
import 'screens/Color Matching Game/ColorMatchingInstructions.dart';
import 'package:game_project/screens/TertiesGame/board.dart';
import 'package:game_project/screens/TertiesGame/instructions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import './screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}
//tt

class Score extends ChangeNotifier {

int scoreForObservationGame = 0;
int scoreForMathematicsGame = 0; 
int scoreForAccuracyGame = 0; 
int scoreForLogicGame = 0; 

double observationLevelPercent = 0.0; 
double mathematicsLevelPercent = 0.0;
double accuracyLevelPercent = 0.0;
double logicLevelPercent = 0.0;

double totalPercent = 0.0;
int level = 0;

addScoreForObservationGames() {
  scoreForObservationGame = scoreForObservationGame + 500;
  notifyListeners();
}
addScoreForAccuracyGames() {
  scoreForAccuracyGame = scoreForAccuracyGame + 500;
  notifyListeners();
}
addScoreForAccuracyGamesClose() {
  scoreForAccuracyGame = scoreForAccuracyGame + 300;
  notifyListeners();
}
addScoreForMathematicsGameGames() {
  scoreForMathematicsGame = scoreForMathematicsGame + 300;
  notifyListeners();
}
addScoreForLogicGameGames() {
  scoreForLogicGame = scoreForLogicGame + 100;
  notifyListeners();
}

restartScoreForObservationGames() {
  double val = (scoreForObservationGame / 1000).roundToDouble();
  scoreForObservationGame = 0;
  updateObservationLevelPercent(val);
  notifyListeners();
}
restartScoreForAccuracyGames() {
  double val = (scoreForAccuracyGame / 1000).roundToDouble();
  scoreForAccuracyGame = 0;
  updateAccuracyLevelPercent(val);
  notifyListeners();
}
restartScoreForMathematicsGames() {
  double val = (scoreForMathematicsGame / 1000).roundToDouble();
  scoreForMathematicsGame = 0;
  updateMathematicsLevelPercent(val);
  notifyListeners();
}
restartScoreForLogicGames() {
  double val = (scoreForLogicGame / 100).roundToDouble();
  scoreForLogicGame = 0;
  updateLogicLevelPercent(val);
  notifyListeners();
}

minScoreForObservationGames() {
  scoreForObservationGame = scoreForObservationGame - 400;
  notifyListeners();
}
minScoreForAccuracyGames() {
  scoreForAccuracyGame = scoreForAccuracyGame - 400;
  notifyListeners();
}
minScoreForMathematicsGames() {
  scoreForMathematicsGame = scoreForMathematicsGame - 400;
  notifyListeners();
}

updateObservationLevelPercent([double val = 0.0]) {
  while (val > 0.0 && observationLevelPercent < 0.9) {
    observationLevelPercent += 0.1;
    val -= 0.1;
    if (observationLevelPercent >= 0.9) {
      updateTotalIndicator();
      observationLevelPercent = 0.1;
    }
    notifyListeners();
  }
}
updateAccuracyLevelPercent([double val = 0.0]) {
  while (val > 0.0 && accuracyLevelPercent < 0.9) {
    accuracyLevelPercent += 0.1;
    val -= 0.1;
    if (accuracyLevelPercent >= 0.9) {
      updateTotalIndicator();
      accuracyLevelPercent = 0.1;
    }
    notifyListeners();
  }
}
updateMathematicsLevelPercent([double val = 0.0]) {
  while (val > 0.0 && mathematicsLevelPercent < 0.9) {
    mathematicsLevelPercent += 0.1;
    val -= 0.1;
    if (mathematicsLevelPercent >= 0.9) {
      updateTotalIndicator();
      mathematicsLevelPercent = 0.1;
    }
    notifyListeners();
  }
}
updateLogicLevelPercent([double val = 0.0]) {
  while (val > 0.0 && logicLevelPercent < 0.9) {
    logicLevelPercent += 0.1;
    val -= 0.1;
    if (logicLevelPercent >= 0.9) {
      updateTotalIndicator();
      logicLevelPercent = 0.1;
    }
    notifyListeners();
  }
}

updateTotalIndicator() {
  if (totalPercent >= 1.0) {
    totalPercent = 0.1;
    level++;
  } else {
    totalPercent += 0.1;
  }
  notifyListeners();
}
}


// when press on the icon 
//  how tochange????

class DarkAndLightMode extends  ChangeNotifier {
  bool IsDark = true;
  var backgroundForHomeScreen = const Color(0xFF161616);
  var textForHomeScreen = Colors.white;

  changeMode() {
    (IsDark) ? IsDark = false : IsDark = true;
    backgroundForHomeScreen = (IsDark) ? const Color(0xFF161616)  : const Color.fromARGB(255, 242, 249, 255);
    textForHomeScreen = (IsDark) ? Colors.white : Color.fromARGB(221, 26, 26, 26);
    notifyListeners();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
      ChangeNotifierProvider(create: (context) => Score()), 
      ChangeNotifierProvider(create: (context) => DarkAndLightMode()), 
    ],

    child : 
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Gameboard(),
      /*
      
      there is error occured when we run the main dart because 
      there are already initial route  for the app so we can not add home property.


      so i change the Gameboard() secreen to be in kholoud section in the home screen 
      
      */
      title: 'Games app',
      initialRoute: '/',
      routes: {
        '/': (context) => const splash(),
        '/home': (context) => const Homescreen(),
        '/FirstGame': (context) => const BiggestNumInstructions(),
        '/SecondGame': (context) => const ArrowInstructions(),
        '/ThirdGame': (context) => const InstructionsBuildGame(), // to be here
        '/FourthGame': (context) =>  const ColorBoxInstructions(),
        '/FifthGame': (context) => const DirectionInstructions(),
        '/SixthGame': (context) => const SameColorInstructions(),
      },
    ));
  }
}
