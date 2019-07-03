import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gdgflutterdemo/widgets/adaptive_page_scaffold.dart';

class AuthScreen extends StatelessWidget {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  void _handleSignInGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await _auth.signInWithCredential(credential);
  }

  void _handleSignInFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final FacebookLoginResult result =
        await _facebookLogin.logInWithReadPermissions(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        await _auth.signInWithCredential(credential);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CANCELLED BY USER HERE");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        print("ERROR HERE");
        break;
    }
  }

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
                onPressed: _handleSignInGoogle,
                darkMode: true,
              ),
              FacebookSignInButton(
                onPressed: _handleSignInFacebook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
