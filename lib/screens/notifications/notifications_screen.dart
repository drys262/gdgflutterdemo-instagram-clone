import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';

class NotificationsScreen extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const NotificationsScreen({Key key, this.tabController, this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Here'),
    );
  }
}
