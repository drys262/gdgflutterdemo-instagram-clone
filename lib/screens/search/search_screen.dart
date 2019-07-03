import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const SearchScreen({Key key, this.tabController, this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Here'),
    );
  }
}
