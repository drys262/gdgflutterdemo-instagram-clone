import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gdgflutterdemo/screens/questions/questions_list.dart';
import 'package:gdgflutterdemo/services/services.dart';

class QuestionsScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey;

  QuestionsScreen({Key key, this.scaffoldKey}) : super(key: key);

  void _addQuestion(BuildContext context) {
    addQuestionToFirestore(context, _textEditingController.text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("MAIN BUILD IN QUESTIONS SCREEN HERE");
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    maxLines: 2,
                    controller: _textEditingController,
                    decoration:
                        InputDecoration(hintText: "Enter question here ..."),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String questionText) => _addQuestion(context),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: RaisedButton.icon(
                  icon: Icon(Icons.add_comment),
                  label: Text('Add'),
                  onPressed: () => _addQuestion(context),
                ),
              )
            ],
          ),
          QuestionsList()
        ],
      ),
    );
  }
}
