import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  int numberofgames = 6;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DarkAndLightMode color =
        Provider.of<DarkAndLightMode>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("  Games : ",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontFamily: "Montserrat",
                color: color.textForHomeScreen)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              0.3, // Adjust the height as needed
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, "/ThirdGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/TetrisGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              left: 30,
                              child: Stack(children: [
                                // Text with white stroke
                                Text(
                                  "💎 Premium Game",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: "Montserrat",
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = Colors.white,
                                  ),
                                ),
                                const Text(
                                  "💎 Premium Game",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    fontFamily: "Montserrat",
                                    color: Colors.cyan,
                                  ),
                                ),
                              ])),
                          const Center(
                              child: Text(
                            "Tetris Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Tetris Game ^
                  GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, "/FirstGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/BiggestNumberGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          const Center(
                              child: Text(
                            "Biggest Number Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Biggest Number Game ^
                  GestureDetector(
                      onTap: () =>
                          {Navigator.pushNamed(context, "/SecondGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/RotateArrowGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          const Center(
                              child: Text(
                            "Rotate Arrow Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Rotate Arrow Game ^
                  GestureDetector(
                      onTap: () =>
                          {Navigator.pushNamed(context, "/FourthGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/BrightestColorGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          const Center(
                              child: Text(
                            "Brightest Color Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Brightest Color Game ^
                  GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, "/FifthGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/DirectionsGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          const Center(
                              child: Text(
                            "Directions Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Directions Game ^
                  GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, "/SixthGame")},
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(0xFFEDF6FA), width: 0.5),
                              color: Colors.black
                                  .withOpacity(0.3), // Adjust opacity as needed
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/ColorMatchingGame.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            left: 20,
                            right: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(
                                      0.3), // Adjust opacity as needed
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                          const Center(
                              child: Text(
                            "Color Matching Game",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                            ),
                          )),
                        ],
                      )),
                  // Color Matching Game ^
                ],
              ),
              Positioned(
                bottom: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6, // Adjust the number of dots based on the number of pages
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            index == _currentPage ? Colors.white : Colors.grey,
                        border: index == _currentPage
                            ? Border.all(
                                color: const Color(0xFFEDF6FA), width: 0.5)
                            : null,
                        boxShadow: index == _currentPage
                            ? const [
                                BoxShadow(
                                    color: Color(0xFFE8F3FA),
                                    blurRadius: 10,
                                    offset: Offset(0, 0))
                              ]
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
