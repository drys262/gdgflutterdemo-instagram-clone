import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';

AppBar getHomeAppBar(TabController tabController, List<Widget> tabs) {
  return AppBar(
    title: Text("Home"),
    leading: Padding(
      padding: const EdgeInsets.all(8),
      child: StoreConnector<AppState, UserData>(
        converter: (store) => store.state.userData,
        builder: (context, UserData userData) {
          return CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userData.user.photoUrl),
          );
        },
      ),
    ),
    bottom: TabBar(
      controller: tabController,
      tabs: tabs,
    ),
  );
}
