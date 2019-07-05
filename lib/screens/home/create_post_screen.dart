import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/home/widgets/write_caption.dart';
import 'package:gdgflutterdemo/services/services.dart';
import 'package:gdgflutterdemo/widgets/adaptive_page_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostScreen extends StatelessWidget {
  void _addPost(BuildContext context) async {
    AppState state = StoreProvider.of<AppState>(context).state;
    String postId =
        Firestore.instance.collection('posts').document().documentID;
    uploadFileToStorage(postId, state.createPostData);
    await addPostToFirestore(postId, state);
    Application.router.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String title = "New Post";
    return AdaptivePageScaffold(
      title: title,
      child: Column(
        children: <Widget>[
          WriteCaption(),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _addPost(context),
        )
      ],
    );
  }
}
