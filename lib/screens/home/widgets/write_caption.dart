import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/screens/home/widgets/caption_field.dart';
import 'package:gdgflutterdemo/screens/home/widgets/caption_image.dart';

class WriteCaption extends StatelessWidget {
  final double imageWidth = 80;
  final double imageHeigth = 80;

  @override
  Widget build(BuildContext context) {
    print("BUILD HERE ALWAYS in BASE WRITE CAPTION");
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: CaptionImage(),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CaptionField(),
            ),
          ),
        ],
      ),
    );
  }
}
