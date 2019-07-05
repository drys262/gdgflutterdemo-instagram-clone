import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/widgets/helper_widgets.dart';

import 'package:gdgflutterdemo/util/platform.dart' show isIOS;
import 'package:gdgflutterdemo/util/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: getTabs().length);
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
            appBar: getMainAppBar(_tabController, getTabs()),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: getScreens().map((screen) {
                return screen;
              }).toList(),
            ),
          );
  }
}
