import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gdgflutterdemo/util/platform.dart' show isIOS;

class AdaptiveProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator();
  }
}
