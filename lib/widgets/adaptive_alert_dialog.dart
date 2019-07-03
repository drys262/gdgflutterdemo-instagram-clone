import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class AdaptiveAlertDialog extends StatelessWidget {
  final String dialogTitle;
  final String content;
  final List<Widget> actions;

  AdaptiveAlertDialog(
      {Key key,
      @required this.dialogTitle,
      @required this.content,
      @required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoAlertDialog(
            title: Text(dialogTitle),
            content: Text(content),
            actions: actions,
          )
        : AlertDialog(
            title: Text(dialogTitle),
            content: Text(content),
            actions: actions,
          );
  }
}
