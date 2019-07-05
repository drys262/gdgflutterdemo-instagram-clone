import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';

class FeedUserInfo extends StatelessWidget {
  final User user;

  const FeedUserInfo({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.photoUrl),
          ),
        ),
        Text(user.displayName)
      ],
    );
  }
}
