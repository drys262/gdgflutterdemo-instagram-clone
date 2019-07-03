import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/config/application.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/home/widgets/write_caption.dart';
import 'package:gdgflutterdemo/widgets/adaptive_page_scaffold.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePollScreen extends StatelessWidget {
  void _addPoll(BuildContext context) async {
    AppState state = StoreProvider.of<AppState>(context).state;
    HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: "httpPollCreateTopic");
    String pollId =
        Firestore.instance.collection('polls').document().documentID;

    print("------ ADD POLL HERE ---- ");
    Map<String, dynamic> params = {
      'public': true,
      'pollId': pollId,
    };

    print(params);
    HttpsCallableResult result = await callable.call(params);
    print(result.data);
    Application.router.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String title = "New Poll";
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
          onPressed: () => _addPoll(context),
        )
      ],
    );
  }
}
