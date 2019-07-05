import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  FirebaseUser user;
  String uid;
  UserData(this.user, this.uid);
}

class User {
  String uid;
  String email;
  String displayName;
  String photoUrl;
  User({this.uid, this.email, this.displayName, this.photoUrl});

  User.fromPostMap(Map<String, dynamic> data) {
    this.uid = data['userId'];
    this.email = data['email'];
    this.displayName = data['displayName'];
    this.photoUrl = data['photoUrl'];
  }

  User.fromDocSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    this.uid = snapshot.documentID;
    this.displayName = data['displayName'];
    this.email = data['profile']['email'];
    this.photoUrl = data['profile']['photoUrl'];
  }

  User.fromFirebaseUser(FirebaseUser user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.email = user.email;
    this.photoUrl = user.photoUrl;
  }
}
