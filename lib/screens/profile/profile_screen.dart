import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/util/helper.dart';
import 'package:gdgflutterdemo/widgets/adaptive_alert_dialog.dart';
import 'package:gdgflutterdemo/widgets/adaptive_button.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class ProfileScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProfileScreen({Key key, this.scaffoldKey}) : super(key: key);

  void yesHandler(BuildContext context) {
    logout();
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

    AppState state = StoreProvider.of<AppState>(context).state;
    User user = User.fromFirebaseUser(state.userData.user);
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              maxRadius: 70,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
          ),
          Text('${user.displayName}'),
          AdaptiveButton(
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
        ],
      ),
    );
  }
}
