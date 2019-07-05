import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/search/search_card.dart';
import 'package:gdgflutterdemo/widgets/adaptive_progress_indicator.dart';
import 'package:gdgflutterdemo/widgets/firestore_stream_list_view.dart';

class SearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      distinct: true,
      converter: (store) => store.state.formData.searchUserText,
      builder: (BuildContext context, String searchText) {
        Stream<QuerySnapshot> stream = searchText.isNotEmpty
            ? Firestore.instance
                .collection('users')
                .where("profile.email", isEqualTo: searchText)
                .snapshots()
            : Firestore.instance.collection('users').snapshots();
        return Expanded(
          child: FirestoreStreamListView(
            collectionStream: stream,
            itemWidget: (DocumentSnapshot document) => SearchCard(
                  currentDocument: document,
                ),
            loadingWidget: Center(
              child: AdaptiveProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
