import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class AdaptivePageScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  AdaptivePageScaffold(
      {Key key, @required this.child, this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            resizeToAvoidBottomInset: true,
            navigationBar: CupertinoNavigationBar(
              middle: Text(title),
            ),
            child: child,
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(title),
              centerTitle: true,
              actions: actions,
            ),
            body: child,
          );
  }
}
