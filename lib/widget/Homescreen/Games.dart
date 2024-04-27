import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Games : ", style: TextStyle(fontFamily: 'POP', fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Container(
          height: MediaQuery.of(context).size.height * 0.1, // Adjust the height as needed
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/FirstGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.green,),
                  child: const Center(child: Text("Monaia")),
              ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/SecondGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.blue,),
                  child: const Center(child: Text("Ahmed")),
              ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/ThirdGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.yellow,),
                  child: const Center(child: Text("Kholoud")),
              ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/FourthGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.white,),
                  child: const Center(child: Text("Mohamed")),
              ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/FifthGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.greenAccent,),
                  child: const Center(child: Text("Fifth")),
              ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context , "/SixthGame")
                },
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.greenAccent,),
                  child: const Center(child: Text("Sixth")),
              ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}