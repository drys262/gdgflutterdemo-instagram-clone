import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/actions/route_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

FacebookLogin _facebookLogin = FacebookLogin();
FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

Map<String, dynamic> convertToStringMap(Map<dynamic, dynamic> data) {
  return data != null
      ? Map<String, dynamic>.from(data)
      : Map<String, dynamic>();
}

void logout() async {
  await _facebookLogin.logOut();
  await _googleSignIn.signOut();
  await _auth.signOut();
}

void changeTabIndex(BuildContext context, int index) {
  StoreProvider.of<AppState>(context).dispatch(ChangeScaffoldKey(index));
}

void handleSignInGoogle() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  await _auth.signInWithCredential(credential);
}

void handleSignInFacebook() async {
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

void saveDeviceToken() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print(user);
  print(user.uid);
  String deviceToken = await FirebaseMessaging().getToken();
  if (deviceToken != null) {
    DocumentReference tokenRef = Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('tokens')
        .document(deviceToken);
    await tokenRef.setData({
      'token': deviceToken,
      'createdAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem
    });
  }
}
