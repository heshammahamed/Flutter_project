import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class MohamedGame extends StatefulWidget {
  const MohamedGame({super.key});

  @override
  State<MohamedGame> createState() => _MohamedGameState();
}

class _MohamedGameState extends State<MohamedGame> {
  int score = 100; // عدد النقاط
  Color mainColor = Colors.red[500]!; // اللون الأساسي
  Color brightestColor = Colors.red[400]!; // اللون الأساسي المشرق

  // مكان ظهور اللون المختلف
  int differentColorIndex = 0;

  int timerValue = 120; // قيمة الوقت بالثواني
  late Timer _timer; // تايمر

  @override
  void initState() {
    super.initState();
    // بدء التايمر عند تهيئة الحالة
    _startTimer();
  }

  // دالة لبدء التايمر
  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (timer) {
        setState(() {
          if (timerValue < 1) {
            timer.cancel();
          } else {
            timerValue--;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "different the degree color",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            right: 10,
            left: 10,
          ),
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(10)), //علشان اعمل حواف دائريه للكونتينر
            border: Border.all(color: Colors.black, width: 5), //البرواز الخارجى
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns in the grid
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
            ),

            itemCount: 9, // Total number of items in the grid
            itemBuilder: (BuildContext context, int index) {
              // تحديد مكان ظهور اللون المختلف
              if (index == differentColorIndex) {
                return GestureDetector(
                  onTap: () {
                    // عندما يضغط المستخدم على اللون المختلف
                    setState(() {
                      // تحديث النقاط
                      score += 10;
                      // توليد درجة عشوائية قريبة للون الأساسي
                      int randomIncrement = Random().nextInt(100);
                      mainColor = Color.fromRGBO(
                        mainColor.red + randomIncrement,
                        mainColor.green + randomIncrement,
                        mainColor.blue + randomIncrement,
                        1,
                      );
                      brightestColor = Color.fromRGBO(
                        brightestColor.red + randomIncrement,
                        brightestColor.green + randomIncrement,
                        brightestColor.blue + randomIncrement,
                        1,
                      );
                      // توليد رقم عشوائي لتحديد مكان جديد للون المختلف
                      differentColorIndex = Random().nextInt(9);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: brightestColor,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    width: 111,
                    height: 370,
                  ),
                );
              } else {
                // This function is called for every item in the grid
                // It returns the widget to display for each item
                return GestureDetector(
                  onTap: () {
                    // عندما يضغط المستخدم على الألوان الأخرى
                    setState(() {
                      // تحديث النقاط
                      score -= 5;
                      // توليد درجة عشوائية جديدة للون الأساسي
                      mainColor = Color.fromRGBO(
                        Random().nextInt(256),
                        Random().nextInt(256),
                        Random().nextInt(256),
                        1,
                      );
                      // تحديد اللون المشرق
                      brightestColor = Color.fromRGBO(
                        mainColor.red - 100,
                        mainColor.green - 100,
                        mainColor.blue - 100,
                        1,
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    width: 111,
                    height: 370,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // إلغاء التايمر عند تجميع الحالة
    _timer.cancel();
    super.dispose();
  }
}
