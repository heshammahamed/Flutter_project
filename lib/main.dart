import 'package:flutter/material.dart';
import './screens/homescreen.dart';
import 'screens/BiggestNumberGame/BiggestNumberInstructions.dart';
import 'screens/Rotate Arrow Game/RotateArrowInstructions.dart';
import 'screens/BrightestColorGame/BrightestColorInstructions.dart';
import 'screens/DirectionsGame/DirectionInstructions.dart';
import 'screens/ColorMatchingGame/ColorMatchingInstructions.dart';
import 'package:game_project/screens/TertiesGame/instructions.dart';
import 'package:provider/provider.dart';
import './screens/splashScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

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
    scoreForMathematicsGame = scoreForMathematicsGame + 500;
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
    if (scoreForObservationGame < 0) {
      scoreForObservationGame = 0;
    }
    notifyListeners();
  }

  minScoreForAccuracyGames() {
    scoreForAccuracyGame = scoreForAccuracyGame - 400;
    if (scoreForAccuracyGame < 0) {
      scoreForAccuracyGame = 0;
    }
    notifyListeners();
  }

  minScoreForMathematicsGames() {
    scoreForMathematicsGame = scoreForMathematicsGame - 400;
    if (scoreForMathematicsGame < 0) {
      scoreForMathematicsGame = 0;
    }
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
    totalPercent += 0.1;
    if (totalPercent > 1.0) {
      totalPercent = 0.1;
      level++;
    }
    notifyListeners();
  }
}

class DarkAndLightMode extends ChangeNotifier {
  bool isDark = true;
  var backgroundForHomeScreen = const Color(0xFF161616);
  var textForHomeScreen = Colors.white;
  var gamesContainer = const Color.fromARGB(255, 1, 0, 19);
  var gamesContainerStroke = const Color(0xFF2C2C2E);
  var gamesAppbar = const Color(0xFF263238);
  var rotatearrowgameMainarrow = const Color(0xFF0DAAFF);
  var rotatearrowgameUserarrow = Colors.white;
  var rotatearrowgameRotatebuttons = const Color(0xFFA6A6A6);
  var rotatearrowgameCheckbutton = const Color(0xFF00C853);
  var biggestnumbergameEqualbutton = const Color(0xFF00C853);
  var biggestnumbersNumbers = const Color.fromARGB(255, 72, 0, 0);
  var darklightIconcolor = const Color(0xFFFDB813);
  var darklightIcon = FontAwesomeIcons.solidSun;

  changeMode() {
    (isDark) ? isDark = false : isDark = true;
    backgroundForHomeScreen = (isDark)
        ? const Color(0xFF161616)
        : const Color.fromARGB(255, 242, 249, 255);
    textForHomeScreen =
        (isDark) ? Colors.white : const Color.fromARGB(221, 26, 26, 26);
    gamesContainer =
        (isDark) ? const Color.fromARGB(255, 1, 0, 19) : Colors.white;
    gamesContainerStroke =
        (isDark) ? const Color(0xFF2C2C2E) : const Color(0xFFEDF6FA);
    gamesAppbar = (isDark) ? const Color(0xFF263238) : const Color(0xFF1976D2);
    rotatearrowgameMainarrow =
        (isDark) ? const Color(0xFF0DAAFF) : const Color(0xFF1976D2);
    rotatearrowgameUserarrow =
        (isDark) ? Colors.white : const Color.fromARGB(221, 26, 26, 26);
    rotatearrowgameRotatebuttons =
        (isDark) ? const Color(0xFFA6A6A6) : const Color(0xFF607D8B);
    rotatearrowgameCheckbutton = (isDark)
        ? const Color(0xFF00C853)
        : const Color.fromARGB(255, 0, 149, 5);
    biggestnumbersNumbers =
        (isDark) ? const Color.fromARGB(255, 72, 0, 0) : Colors.white;
    biggestnumbergameEqualbutton = (isDark)
        ? const Color(0xFF00C853)
        : const Color.fromARGB(255, 0, 149, 5);
    darklightIconcolor =
        (isDark) ? const Color(0xFFFDB813) : const Color(0xFF91A3B0);
    darklightIcon =
        (isDark) ? FontAwesomeIcons.solidSun : FontAwesomeIcons.solidMoon;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Score()),
          ChangeNotifierProvider(create: (context) => DarkAndLightMode()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Games app',
          initialRoute: '/',
          routes: {
            '/': (context) => const splash(),
            '/home': (context) => const Homescreen(),
            '/FirstGame': (context) => const BiggestNumInstructions(),
            '/SecondGame': (context) => const ArrowInstructions(),
            '/ThirdGame': (context) =>
                const InstructionsBuildGame(), // to be here
            '/FourthGame': (context) => const ColorBoxInstructions(),
            '/FifthGame': (context) => const DirectionInstructions(),
            '/SixthGame': (context) => const SameColorInstructions(),
          },
        ));
  }
}
