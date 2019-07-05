import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/util/helper.dart';

class SearchCard extends StatelessWidget {
  final DocumentSnapshot currentDocument;
  const SearchCard({Key key, this.currentDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState state = StoreProvider.of<AppState>(context).state;
    User currentUser = User.fromFirebaseUser(state.userData.user);
    User receiverUser = User.fromDocSnapshot(currentDocument);

    if (currentDocument.documentID != currentUser.uid) {
      return SafeArea(
        minimum: EdgeInsets.all(5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          currentDocument.data['profile']["photoUrl"]),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      currentDocument.data['profile']["email"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.video_call),
                      onPressed: () =>
                          onCallUser(currentUser, receiverUser, context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
