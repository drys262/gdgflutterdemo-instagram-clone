import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';

class CaptionField extends StatefulWidget {
  @override
  _CaptionFieldState createState() => _CaptionFieldState();
}

class _CaptionFieldState extends State<CaptionField> {
  @override
  Widget build(BuildContext context) {
    print("BUILD CAPTION FIELD HERE");
    return TextField(
      textAlign: TextAlign.left,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: "Write a caption...",
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
    );
  }
}
