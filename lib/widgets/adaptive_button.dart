import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  AdaptiveButton({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoButton.filled(
            child: Text(text),
            onPressed: onPressed,
          )
        : RaisedButton(
            onPressed: onPressed,
            child: Text(text),
          );
  }
}
