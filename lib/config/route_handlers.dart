import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/screens/home/create_post_screen.dart';
import 'package:gdgflutterdemo/screens/search/video_call_screen.dart';
import 'package:gdgflutterdemo/screens/search/video_incoming_screen.dart';
import 'package:gdgflutterdemo/services/services.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return null;
});

var createPostHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreatePostScreen();
});

var goToVideoCallHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String channelId = params['channelId'][0];
  return VideoCallScreen(channelId: channelId);
});

var goToIncomingVideoCallHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String channelId = params['channelId'][0];
  String userId = params['userId'][0];
  return VideoIncomingScreen(
    channelId: channelId,
    userId: userId,
  );
});
