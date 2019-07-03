import 'package:flutter/material.dart';

AppBar getProfileAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("Profile"),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
