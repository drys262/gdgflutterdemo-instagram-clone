import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'models/create_post_data.dart';

class AppState {
  final UserData userData;
  final CreatePostData createPostData;

  factory AppState.initial() {
    UserData userData = UserData(null, "");
    CreatePostData createPostData = CreatePostData(null, "");
    return AppState(userData, createPostData);
  }

  AppState(this.userData, this.createPostData);
}
