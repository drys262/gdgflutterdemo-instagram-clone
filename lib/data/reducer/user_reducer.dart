import 'package:gdgflutterdemo/data/actions/auth_actions.dart';
import 'package:redux/redux.dart';

import '../models/user_data.dart';

final userReducer = combineReducers<UserData>([
  TypedReducer<UserData, ChangeUser>(_changeUser),
]);

UserData _changeUser(UserData userData, ChangeUser action) {
  userData.user = action.user;
  userData.uid = action.uid;
  return userData;
}
