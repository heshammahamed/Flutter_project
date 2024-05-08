import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin ديه بتخلينا نعمل مده لهذه الصفحه قبل التنقل للصفحه التانيه د

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Homescreen()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double
            .infinity, // double . infinty بتخلى ال كونتينر ياخذ اكبر وwidth
        decoration: const BoxDecoration(
          color: const Color(0xFF161616),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.brain , color: Colors.white , size: 50,),
            SizedBox(
                height:
                    50), //ده بوكس ممكن نحط فيه اى حاجه هنا حاطط اسم البرنامج مثلا
            Text(
              "MiniGames",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
