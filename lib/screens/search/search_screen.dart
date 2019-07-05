import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SearchScreen({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Text("SEARCH HERE"),
      ),
    );
  }
}
