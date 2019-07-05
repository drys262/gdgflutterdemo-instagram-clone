import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';

class Application {
  static Router router;

  static void configureFcm(FirebaseMessaging fcm, BuildContext context,
      TabController tabController) {
    fcm.subscribeToTopic("posts");
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        AppState state = StoreProvider.of<AppState>(context).state;
        int scaffoldKeyIndex = state.scaffoldKeyIndex;
        GlobalKey<ScaffoldState> currentScaffoldKey =
            state.globalScaffoldKeys[scaffoldKeyIndex];
        print("BEFORE ON MESSAGE TEXT");
        print("onMessage: $message");
        final SnackBar snackbar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
            label: "View",
            onPressed: () {
              if (tabController.index != 0) {
                tabController.animateTo(0);
              }
            },
          ),
        );
        currentScaffoldKey.currentState.showSnackBar(snackbar);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
