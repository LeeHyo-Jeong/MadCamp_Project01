import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madcamp_project01/Homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'util.dart';
import 'theme.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones(); // 타임존 데이터 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context);

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // theme: theme.light(),
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
    Timer(Duration(milliseconds: 3000), () {
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
