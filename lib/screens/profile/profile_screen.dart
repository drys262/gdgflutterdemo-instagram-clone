import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdgflutterdemo/widgets/adaptive_alert_dialog.dart';
import 'package:gdgflutterdemo/widgets/adaptive_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class ProfileScreen extends StatelessWidget {
  static final FacebookLogin _facebookLogin = FacebookLogin();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  final TabController tabController;
  final List<Tab> tabs;

  const ProfileScreen({Key key, this.tabController, this.tabs})
      : super(key: key);

  void _logout() async {
    await _facebookLogin.logOut();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  void yesHandler(BuildContext context) {
    _logout();
    Navigator.pop(context);
  }

  void noHandler(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    String logoutWarningTitle = "Confirm";
    String logoutWarningMessage = "Are you sure you want to log-out?";
    List<Widget> iosActions = [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text("Yes"),
        onPressed: () => yesHandler(context),
      ),
      CupertinoDialogAction(
        child: Text("No"),
        onPressed: () => noHandler(context),
      )
    ];

    List<Widget> androidActions = [
      FlatButton(
        child: Text("Yes"),
        onPressed: () => yesHandler(context),
      ),
      FlatButton(
        child: Text("No"),
        onPressed: () => noHandler(context),
      ),
    ];
    Function show = isIOS ? showCupertinoDialog : showDialog;
    return Center(
      child: AdaptiveButton(
        onPressed: () {
          show(
            context: context,
            builder: (BuildContext context) {
              return AdaptiveAlertDialog(
                dialogTitle: logoutWarningTitle,
                content: logoutWarningMessage,
                actions: isIOS ? iosActions : androidActions,
              );
            },
          );
        },
        text: "Logout",
      ),
    );
  }
}
