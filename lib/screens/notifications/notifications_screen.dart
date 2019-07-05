import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NotificationsScreen({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Text('Notifications Here'),
      ),
    );
  }
}
