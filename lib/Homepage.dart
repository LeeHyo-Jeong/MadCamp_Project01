import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:madcamp_project01/contact_list.dart';
import 'package:madcamp_project01/image_list.dart';
import 'package:madcamp_project01/weather_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  late String _appBarTitle;

  @override
  void initState() {
    super.initState();
    _appBarTitle = "Contacts"; // 초기 AppBar 제목
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // 시스템 네비게이션 바 없애기
    WidgetsBinding.instance.addObserver(this);
    _hideSystemBars();
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
          _appBarTitle = "Weather";
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // 시스템 네비게이션 바 없애기
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _hideSystemBars();
    }
  }

  void _hideSystemBars() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
  }

  void _deleteConfirmDialog(bool bool1) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Text("Exit", style: TextStyle(color: Colors.black),),
          content: Text("Are you sure you want to exit?", style: TextStyle(color: Colors.black),),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.black54,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Exit",
                  style: TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: _deleteConfirmDialog,
        child: Scaffold(
            body: TabBarView(
              controller: _tabController,
              children: [
                ContactsWidget(),
                ImageWidget(),
                WeatherWidget(),
              ],
            ),
            bottomNavigationBar: Ink(
              child: TabBar(
                labelColor: Colors.black54,
                unselectedLabelColor: Colors.black38,
                indicatorColor: Color(0xff00bfff),
                controller: _tabController,
                tabs: [
                  InkWell(
                    splashColor: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Color(0xff00bfff) : Colors.white,
                    child: Tab(icon: Icon(Icons.phone, color: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Colors.grey : Color(
                        0xffbee6ff),)),
                  ),
                  InkWell(
                    splashColor: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Color(0xff00bfff) : Colors.white,
                    child: Tab(icon: Icon(Icons.photo_library, color: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Colors.grey : Color(
                        0xffbee6ff),)),
                  ),
                  InkWell(
                    splashColor: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Color(0xff00bfff) : Colors.white,
                    child: Tab(icon: Icon(Icons.cloud, color: View.of(context).platformDispatcher.platformBrightness == Brightness.light ? Colors.grey : Color(
                        0xffbee6ff),)),
                  ),
                ],
              ),
            )));
  }
}
