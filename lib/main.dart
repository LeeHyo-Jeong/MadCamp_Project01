import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madcamp_project01/Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LodingPage(),
    );
  }
}

class LodingPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LodingPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage()
      )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Color(0xff98e0ff),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                // Container(
                //   child: SvgPicture.asset(
                //     'assets/images/public/PurpleLogo.svg',
                //     width: screenWidth * 0.616666,
                //     height: screenHeight * 0.0859375,
                //   ),
                // ),
                Expanded(child: SizedBox()),
                Align(
                  child: Text(
                    "© Copyright 2024, 몰입캠프 Week1",
                    style: TextStyle(
                      fontSize: screenWidth * (14 / 360),
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.0625),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
