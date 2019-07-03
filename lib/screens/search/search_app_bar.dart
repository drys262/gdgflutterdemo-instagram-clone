import 'package:flutter/material.dart';

AppBar getSearchAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("Search"),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
