import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'models/create_post_data.dart';

class AppState {
  final UserData userData;
  final CreatePostData createPostData;
  final List<GlobalKey<ScaffoldState>> globalScaffoldKeys;
  final int scaffoldKeyIndex;

  static List<GlobalKey<ScaffoldState>> defaultGlobalScaffoldKeys =
      List<int>.generate(5, (i) => i + 1)
          .map((index) => GlobalKey<ScaffoldState>())
          .toList();

  factory AppState.initial() {
    UserData userData = UserData(null, "");
    CreatePostData createPostData = CreatePostData(null, "");

    return AppState(userData, createPostData,
        globalScaffoldKeys: AppState.defaultGlobalScaffoldKeys,
        scaffoldKeyIndex: 0);
  }

  AppState(this.userData, this.createPostData,
      {this.globalScaffoldKeys, this.scaffoldKeyIndex = 0});
}
