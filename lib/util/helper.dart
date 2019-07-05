import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/data/actions/route_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/services/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

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

Future handleCameraAndMic() async {
  await PermissionHandler()
      .requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);
}

void onCallUser(User caller, User receiver, BuildContext context) async {
  await handleCameraAndMic();
  String channelId = Uuid().v1();
  String path = '/goToVideoCall/$channelId';
  addChannelToFirestore(channelId, caller, receiver);
  addReceiverNotification(channelId, caller, receiver);
  Application.router
      .navigateTo(context, path, transition: TransitionType.nativeModal);
}

void addReceiverNotification(
    String channelId, User caller, User receiver) async {
  try {
    HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "httpVideoCallCreateChannel");
    Map<String, dynamic> params = {
      'caller': getUserInfo(caller),
      'receiver': getUserInfo(receiver),
      'channelId': channelId,
    };
    HttpsCallableResult result = await callable.call(params);
  } on CloudFunctionsException catch (e) {
    print(e.code);
    print(e.message);
    print(e.details);
  } catch (e) {
    rethrow;
  }
}
