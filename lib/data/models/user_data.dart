import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  FirebaseUser user;
  String uid;
  UserData(this.user, this.uid);
}
