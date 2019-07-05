import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionsCard extends StatelessWidget {
  final DocumentSnapshot currentDocument;

  const QuestionsCard({Key key, this.currentDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(5.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        currentDocument.data['user']["profileUrl"]),
                  ),
                ),
                Flexible(
                  child: Text(
                    currentDocument.data['user']["email"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      currentDocument.data["questions"],
                      textAlign: TextAlign.left,
                      maxLines: 6,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
            )
          ],
        ),
      ),
    );
  }
}
