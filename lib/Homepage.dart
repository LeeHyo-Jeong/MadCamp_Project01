import 'package:flutter/material.dart';
import 'package:madcamp_project01/contact_list.dart';
import 'package:madcamp_project01/image_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage>
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: Color(0xff98e0ff),
          title: Text(
              _appBarTitle
          ),
          centerTitle: true,
        ),
        body:
        TabBarView(
          controller: _tabController,
          children: [
            Column( // main의 appbar와 contact page의 appbar 사이 간격 조정
              children: [
                SizedBox(height: 10),
                Expanded(child: ContactsWidget()),
              ],
            ),
            ImageWidget(),
            Center(child: Text('Content for Tab 3')),
          ],
        ),
        bottomNavigationBar: Ink(
          color: Color(0xfff7f2f9),
          child: TabBar(
            labelColor: Colors.black54,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Color(0xff00bfff),

            controller: _tabController,
            tabs: [
              InkWell(
                splashColor: Color(0xff00bfff),
                child: Tab(icon: Icon(Icons.phone)),
              ),
              InkWell(
                splashColor: Color(0xff00bfff),
                child: Tab(icon: Icon(Icons.photo_library)),
              ),
              InkWell(
                splashColor: Color(0xff00bfff),
                child: Tab(icon: Icon(Icons.menu)),
              ),
            ],
          ),
        ));
  }
}
