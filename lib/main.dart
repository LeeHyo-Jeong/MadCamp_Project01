import 'package:flutter/material.dart';
import 'package:madcamp_project01/contact_list.dart';
import 'package:madcamp_project01/image_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3, // 탭의 개수
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff98e0ff),
            title: Text("Application"),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Contacts'),
                Tab(text: 'Gallery'),
                Tab(text: 'Tab 3'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ContactsWidget(), // 연락처 위젯 사용
              ImageWidget(),
              Center(child: Text('Content for Tab 3')),
            ],
          ),
        ),
      ),
    );
  }
}
