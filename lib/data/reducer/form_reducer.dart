import 'package:gdgflutterdemo/data/actions/form_actions.dart';
import 'package:gdgflutterdemo/data/models/form_data.dart';
import 'package:redux/redux.dart';

final formReducer = combineReducers<FormData>([
  TypedReducer<FormData, ChangeSearchUserText>(_changeSearchUserText),
]);

FormData _changeSearchUserText(FormData formData, ChangeSearchUserText action) {
  formData.searchUserText = action.searchText;
  return formData;
}
