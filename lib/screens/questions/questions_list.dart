import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/screens/questions/questions_card.dart';
import 'package:gdgflutterdemo/widgets/adaptive_progress_indicator.dart';
import 'package:gdgflutterdemo/widgets/firestore_stream_list_view.dart';

class QuestionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreStreamListView(
        collectionName: "questions",
        itemWidget: (DocumentSnapshot document) => QuestionsCard(
              currentDocument: document,
            ),
        loadingWidget: Center(
          child: AdaptiveProgressIndicator(),
        ),
      ),
    );
  }
}
