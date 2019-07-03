import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  HomeScreen({Key key, this.tabController, this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Here'),
    );
  }
}
