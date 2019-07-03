import 'package:flutter/material.dart';

AppBar getNotificationAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("Notifications"),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
