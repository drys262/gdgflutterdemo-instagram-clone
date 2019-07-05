import 'dart:typed_data';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:gdgflutterdemo/data/app_state.dart';

class CaptionImage extends StatelessWidget {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  final double imageWidth = 80;
  final double imageHeigth = 80;

  Widget _buildImage(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    print("BUILD IMAGE HERE");
    print(snapshot.connectionState);
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Container(width: imageWidth, height: imageHeigth);
      } else {
        ByteData byteData = snapshot.data;
        Uint8List imageData = byteData.buffer.asUint8List();
        return Image(
          image: MemoryImage(imageData),
        );
      }
    } else {
      print(" ELSE HERE BUILD IMAGE ");
      return Container(width: imageWidth, height: imageHeigth);
    }
  }

  Future<dynamic> _getImage(Asset image) async {
    print("GET IMAGE HERE");
    return this._memoizer.runOnce(() async {
      ByteData data = await image.requestThumbnail(80, 80);
      return data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD HERE CAPTION IMAGE");
    AppState state = StoreProvider.of<AppState>(context).state;
    Asset firstImage = state.createPostData.postImages[0];
    return FutureBuilder(
      future: _getImage(firstImage),
      builder: _buildImage,
    );
  }
}
