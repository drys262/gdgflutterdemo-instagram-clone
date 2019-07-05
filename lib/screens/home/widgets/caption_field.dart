import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/actions/home_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';

class CaptionField extends StatefulWidget {
  @override
  _CaptionFieldState createState() => _CaptionFieldState();
}

class _CaptionFieldState extends State<CaptionField> {
  TextEditingController _textEditingController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("BUILD CAPTION FIELD HERE");
    return Form(
      key: _formKey,
      child: TextField(
        controller: _textEditingController,
        onChanged: (String caption) {
          StoreProvider.of<AppState>(context).dispatch(ChangeCaption(caption));
        },
        textAlign: TextAlign.left,
        maxLines: 3,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "Write a caption...",
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}
