import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:gdgflutterdemo/util/helper.dart';
import 'package:gdgflutterdemo/widgets/adaptive_page_scaffold.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      title: "Login",
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
            children: <Widget>[
              GoogleSignInButton(
                onPressed: handleSignInGoogle,
                darkMode: true,
              ),
              FacebookSignInButton(
                onPressed: handleSignInFacebook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
