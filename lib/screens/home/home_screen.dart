import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/config/routes.dart';
import 'package:gdgflutterdemo/data/actions/home_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/home/home_feed.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _loadImages(BuildContext context) async {
    List<Asset> resultList;
    String error;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
      );
    } on PlatformException catch (e) {
      error = e.message;
    }
    if (resultList.isNotEmpty) {
      StoreProvider.of<AppState>(context)
          .dispatch(ChangePostImages(resultList));
      Application.router.navigateTo(context, Routes.createPost,
          transition: TransitionType.nativeModal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _loadImages(context),
        child: Icon(Icons.add_a_photo),
      ),
      body: HomeFeed(),
    );
  }
}
