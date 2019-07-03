import 'package:firebase_auth/firebase_auth.dart';

class ChangeUser {
  FirebaseUser user;
  String uid;
  ChangeUser(this.user, this.uid);
}
