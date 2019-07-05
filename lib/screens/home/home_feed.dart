import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/screens/home/widgets/home_feed_card.dart';
import 'package:gdgflutterdemo/widgets/adaptive_progress_indicator.dart';
import 'package:gdgflutterdemo/widgets/firestore_stream_list_view.dart';

class HomeFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreStreamListView(
      collectionStream: Firestore.instance
          .collection('posts')
          .orderBy("timestamp", descending: true)
          .snapshots(),
      itemWidget: (DocumentSnapshot document) => HomeFeedCard(
            currentDocument: document,
          ),
      loadingWidget: Center(
        child: AdaptiveProgressIndicator(),
      ),
    );
  }
}
