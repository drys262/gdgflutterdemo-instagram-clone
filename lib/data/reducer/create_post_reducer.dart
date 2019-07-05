import 'package:gdgflutterdemo/data/actions/home_actions.dart';
import 'package:gdgflutterdemo/data/models/create_post_data.dart';
import 'package:redux/redux.dart';

final createPostReducer = combineReducers<CreatePostData>([
  TypedReducer<CreatePostData, ChangePostImages>(_changePostImages),
  TypedReducer<CreatePostData, ChangeCaption>(_changeCaption),
]);

CreatePostData _changePostImages(
    CreatePostData createPostData, ChangePostImages action) {
  createPostData.postImages = action.images;
  return createPostData;
}

CreatePostData _changeCaption(
    CreatePostData createPostData, ChangeCaption action) {
  createPostData.caption = action.caption;
  return createPostData;
}
