import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/data/models/post.dart';
import 'package:gdgflutterdemo/screens/home/widgets/feed_carousel.dart';
import 'package:gdgflutterdemo/screens/home/widgets/feed_user_info.dart';

class HomeFeedCard extends StatelessWidget {
  final DocumentSnapshot currentDocument;
  const HomeFeedCard({Key key, this.currentDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Post post = Post.fromSnapshot(currentDocument);
    return Card(
      margin: EdgeInsets.all(1.0),
      child: Column(
        children: <Widget>[
          FeedUserInfo(
            user: post.user,
          ),
          FeedCarousel(
            postImages: post.postImages,
          )
        ],
      ),
    );
  }
}
