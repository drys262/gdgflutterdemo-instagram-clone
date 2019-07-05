import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/screens/home/create_post_screen.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return null;
});

var createPostHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreatePostScreen();
});
