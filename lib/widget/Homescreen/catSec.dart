import 'package:flutter/material.dart';

class Catego extends StatelessWidget {
  const Catego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categories : ", style: TextStyle(fontFamily: 'POP', fontWeight: FontWeight.w500, fontSize: 30.0, color: Colors.white)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
        Container(
          height: MediaQuery.of(context).size.height * 0.1, // Adjust the height as needed
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.red,),
                
                child: Row (
                  children: [
                    Stack(
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width * 0.1 ,
                          height:MediaQuery.of(context).size.width * 0.1 ,
                          decoration: BoxDecoration(color: Color(0xffF8F8E8) , borderRadius: BorderRadius.circular(50.0)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.1,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.blue,),
                child: const Center(child: Text("Page 2")),
              ),

            ],
          ),
        ),
      ],
    );
  }
}