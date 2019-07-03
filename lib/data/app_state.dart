import 'package:gdgflutterdemo/data/models/user_data.dart';

class AppState {
  final UserData userData;
  // final CreatePollData createPollData;
  // final Map<String, dynamic> formData;

  factory AppState.initial() {
    UserData userData = UserData(null, "");
    // CreatePollData createPollData = CreatePollData(null, "");
    // Map<String, dynamic> formData = {};
    // return AppState(userData, createPollData, formData);
    return AppState(userData);
  }

  AppState(this.userData);
}
