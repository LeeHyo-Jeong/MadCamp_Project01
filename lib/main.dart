import 'package:flutter/material.dart';
import 'package:madcamp_project01/contact_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _appBarTitle;

  @override
  void initState() {
    super.initState();
    _appBarTitle = "Contacts"; // 초기 AppBar 제목
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _appBarTitle = "Contacts";
          break;
        case 1:
          _appBarTitle = "Gallery";
          break;
        case 2:
          _appBarTitle = "Tab 3";
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff98e0ff),
          title: Text(_appBarTitle),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ContactsWidget(), // 연락처 위젯 사용
            Center(child: Text('Gallery')),
            Center(child: Text('Content for Tab 3')),
          ],
        ),
        bottomNavigationBar: Container(
          color: Color(0xfff7f2f9),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.phone)),
              Tab(icon: Icon(Icons.photo_library)),
              Tab(icon: Icon(Icons.menu)),
            ],
          ),
        ));
  }
}
