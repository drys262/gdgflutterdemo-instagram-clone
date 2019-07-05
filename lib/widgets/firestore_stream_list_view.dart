import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/services/services.dart';

class FirestoreStreamListView extends StatelessWidget {
  final Stream<QuerySnapshot> collectionStream;
  final String collectionName;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Function itemWidget;

  static const Widget defaultLoadingWidget = Center(
    child: Text('Fetching ...'),
  );

  static const Widget errorLoadingWidget = Center(
    child: Text("Error fetching"),
  );

  FirestoreStreamListView(
      {this.collectionStream,
      this.itemWidget,
      this.loadingWidget = defaultLoadingWidget,
      this.errorWidget = errorLoadingWidget,
      this.collectionName = ""});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: collectionName.isEmpty
          ? collectionStream
          : getCollectionStream(collectionName),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return errorLoadingWidget;
          } else {
            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data.documents;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot currentDocument = documents[index];
                  return itemWidget(currentDocument);
                },
              );
            }
          }
        } else {
          return loadingWidget;
        }
      },
    );
  }
}
