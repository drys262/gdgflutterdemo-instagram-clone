import 'package:flutter/material.dart';

AppBar getQuestionsAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("Questions"),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      )
    ],
  );
}
