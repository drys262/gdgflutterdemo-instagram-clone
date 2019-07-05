import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/reducer/create_post_reducer.dart';
import 'package:gdgflutterdemo/data/reducer/form_reducer.dart';
import 'package:gdgflutterdemo/data/reducer/user_reducer.dart';
import 'package:gdgflutterdemo/data/reducer/route_reducer.dart';

AppState appReducer(AppState prevState, action) {
  return AppState(
    userReducer(prevState.userData, action),
    createPostReducer(prevState.createPostData, action),
    globalScaffoldKeys: AppState.defaultGlobalScaffoldKeys,
    scaffoldKeyIndex: routeReducer(prevState.scaffoldKeyIndex, action),
    formData: formReducer(prevState.formData, action),
  );
}
