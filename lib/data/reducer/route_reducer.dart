import 'package:gdgflutterdemo/data/actions/route_actions.dart';
import 'package:redux/redux.dart';

final routeReducer = combineReducers<int>([
  TypedReducer<int, ChangeScaffoldKey>(_changeScaffoldKey),
]);

int _changeScaffoldKey(int scaffoldKeyIndex, ChangeScaffoldKey action) {
  scaffoldKeyIndex = action.newScaffoldKeyIndex;
  return scaffoldKeyIndex;
}
