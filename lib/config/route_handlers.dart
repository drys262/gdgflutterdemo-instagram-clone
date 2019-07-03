import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/screens/home/create_poll_screen.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return null;
});

var createPollHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreatePollScreen();
});
