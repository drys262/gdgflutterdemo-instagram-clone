import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class AdaptiveBase extends StatelessWidget {
  final Widget child;

  AdaptiveBase({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoApp(
            home: child,
          )
        : MaterialApp(
            onGenerateRoute: Application.router.generator,
            theme: ThemeData(
                brightness: Brightness.light,
                accentColor: Colors.blueAccent,
                primaryColor: Colors.blueAccent),
            home: child,
          );
  }
}
