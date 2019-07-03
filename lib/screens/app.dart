import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/config/routes.dart';
import 'package:gdgflutterdemo/data/actions/auth_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/main/main_screen.dart';
import 'package:gdgflutterdemo/screens/auth/auth_screen.dart';
import 'package:gdgflutterdemo/widgets/adaptive_base.dart' show AdaptiveBase;

class App extends StatefulWidget {
  final Store<AppState> store;
  App(this.store);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        FirebaseUser user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CupertinoActivityIndicator(
            radius: 15,
          );
        }
        if (user != null) {
          widget.store.dispatch(ChangeUser(user, user.uid));
          return MainScreen();
        } else {
          widget.store.dispatch(ChangeUser(null, ""));
          return AuthScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: AdaptiveBase(
        child: _handleCurrentScreen(),
      ),
    );
  }
}
