import 'package:flutter/material.dart';

AppBar getQuestionsAppBar(
    TabController tabController, List<Widget> tabs, BuildContext context) {
  return AppBar(
    title: Text("Questions"),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
