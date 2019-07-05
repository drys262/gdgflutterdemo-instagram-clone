import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/actions/form_actions.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/screens/search/search_list.dart';

class SearchScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SearchScreen({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    maxLines: 1,
                    controller: _textEditingController,
                    decoration:
                        InputDecoration(hintText: "Search users here ..."),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String searchText) {},
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: RaisedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text('Search'),
                  onPressed: () {
                    String searchText = _textEditingController.text.trim();
                    StoreProvider.of<AppState>(context)
                        .dispatch(ChangeSearchUserText(searchText));
                  },
                ),
              ),
            ],
          ),
          SearchList(),
        ],
      ),
    );
  }
}
