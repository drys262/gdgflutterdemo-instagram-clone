import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/screens/questions/questions_app_bar.dart';
import 'package:gdgflutterdemo/screens/questions/questions_screen.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';

import 'package:gdgflutterdemo/screens/home/home_app_bar.dart';
import 'package:gdgflutterdemo/screens/profile/profile_app_bar.dart';
import 'package:gdgflutterdemo/screens/search/search_app_bar.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;
import 'package:gdgflutterdemo/util/constants.dart';
import 'package:gdgflutterdemo/screens/profile/profile_screen.dart';
import 'package:gdgflutterdemo/screens/search/search_screen.dart';
import 'package:gdgflutterdemo/screens/home/home_screen.dart';
import 'package:gdgflutterdemo/screens/notifications/notifications_screen.dart';
import 'package:gdgflutterdemo/screens/notifications/notifications_app_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Asset> images = List<Asset>();
  String _error;
  int _selectedIndex = 0;
  TabController _tabController;
  AppBar currentAppBar;

  final List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.notifications)),
    Tab(icon: Icon(Icons.person)),
    Tab(icon: Icon(Icons.question_answer)),
  ];

  List<Map<String, dynamic>> getWidgetOptions() {
    final List<Map<String, dynamic>> widgetOptions = [
      {
        'widget': HomeScreen(tabController: _tabController, tabs: _tabs),
        'title': HOME
      },
      {
        'widget': SearchScreen(tabController: _tabController, tabs: _tabs),
        'title': SEARCH
      },
      {
        'widget':
            NotificationsScreen(tabController: _tabController, tabs: _tabs),
        'title': NOTIFICATIONS
      },
      {
        'widget': ProfileScreen(tabController: _tabController, tabs: _tabs),
        'title': PROFILE
      },
      {'widget': QuestionsScreen(), 'title': QUESTIONS},
    ];
    return widgetOptions;
  }

  List<Widget> getScreens() {
    final List<Widget> screens = [
      HomeScreen(tabController: _tabController, tabs: _tabs),
      SearchScreen(tabController: _tabController, tabs: _tabs),
      NotificationsScreen(tabController: _tabController, tabs: _tabs),
      ProfileScreen(tabController: _tabController, tabs: _tabs),
      QuestionsScreen(),
    ];
    return screens;
  }

  AppBar getCurrentAppBar() {
    int index = _tabController.index;
    switch (index) {
      case 0:
        return getHomeAppBar(_tabController, _tabs);
      case 1:
        return getSearchAppBar(_tabController, _tabs);
      case 2:
        return getNotificationAppBar(_tabController, _tabs);
      case 3:
        return getProfileAppBar(_tabController, _tabs);
      case 4:
        return getQuestionsAppBar(_tabController, _tabs);
      default:
        return getHomeAppBar(_tabController, _tabs);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    currentAppBar = getCurrentAppBar();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          currentAppBar = getCurrentAppBar();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem customNavBarItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.lightBlue,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.lightBlue),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    // StoreProvider.of<AppState>(context).dispatch(ChangePollImages(resultList));
    // Application.router.navigateTo(context, Routes.createPoll,
    //     transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD HERE IN MAIN SCREEN");
    return isIOS
        ? CupertinoTabScaffold(
            resizeToAvoidBottomInset: true,
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  title: Text(HOME),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.search),
                  title: Text(SEARCH),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.heart),
                  title: Text(NOTIFICATIONS),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  title: Text(PROFILE),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            tabBuilder: (BuildContext context, index) {
              final _widgetData = getWidgetOptions()[index];
              return CupertinoTabView(
                defaultTitle: _widgetData['title'],
                builder: (BuildContext context) {
                  return _widgetData['widget'];
                },
              );
            },
          )
        : Scaffold(
            appBar: currentAppBar,
            body: TabBarView(
              controller: _tabController,
              children: getScreens().map((screen) {
                return screen;
              }).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: loadAssets,
              child: Icon(Icons.add_a_photo),
            ),
          );
  }
}
