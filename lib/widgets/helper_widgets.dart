import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/screens/home/home_screen.dart';
import 'package:gdgflutterdemo/screens/notifications/notifications_screen.dart';
import 'package:gdgflutterdemo/screens/profile/profile_screen.dart';
import 'package:gdgflutterdemo/screens/questions/questions_screen.dart';
import 'package:gdgflutterdemo/screens/search/search_screen.dart';
import 'package:gdgflutterdemo/util/constants.dart';

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

List<Map<String, dynamic>> getWidgetOptions() {
  final List<Map<String, dynamic>> widgetOptions = [
    {'widget': HomeScreen(), 'title': HOME},
    {'widget': SearchScreen(), 'title': SEARCH},
    {'widget': NotificationsScreen(), 'title': NOTIFICATIONS},
    {'widget': ProfileScreen(), 'title': PROFILE},
    {'widget': QuestionsScreen(), 'title': QUESTIONS},
  ];
  return widgetOptions;
}

List<Widget> getScreens(BuildContext context) {
  List<GlobalKey<ScaffoldState>> globalKeys =
      StoreProvider.of<AppState>(context).state.globalScaffoldKeys;

  final List<Widget> screens = [
    HomeScreen(
      scaffoldKey: globalKeys[0],
    ),
    SearchScreen(
      scaffoldKey: globalKeys[1],
    ),
    NotificationsScreen(
      scaffoldKey: globalKeys[2],
    ),
    ProfileScreen(
      scaffoldKey: globalKeys[3],
    ),
    QuestionsScreen(
      scaffoldKey: globalKeys[4],
    ),
  ];
  return screens;
}

List<Tab> getTabs() => <Tab>[
      Tab(icon: Icon(Icons.home)),
      Tab(icon: Icon(Icons.search)),
      Tab(icon: Icon(Icons.notifications)),
      Tab(icon: Icon(Icons.person)),
      Tab(icon: Icon(Icons.question_answer)),
    ];

AppBar getMainAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("GDG Flutter Demo"),
    leading: Padding(
      padding: const EdgeInsets.all(8),
      child: StoreConnector<AppState, UserData>(
        converter: (store) => store.state.userData,
        builder: (context, UserData userData) {
          return CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userData.user.photoUrl),
          );
        },
      ),
    ),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
