import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gdgflutterdemo/data/app_state.dart';
import 'package:gdgflutterdemo/data/models/create_post_data.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

DocumentReference getUserDoc(String uid) =>
    Firestore.instance.document('users/$uid');
DocumentReference getCollectionDoc(String collection, {String docId}) =>
    Firestore.instance.collection(collection).document();
DocumentReference getDoc(String path) => Firestore.instance.document(path);

Stream<QuerySnapshot> getCollectionStream(String collection) =>
    Firestore.instance
        .collection(collection)
        .orderBy("timestamp", descending: true)
        .snapshots();

void addQuestionToFirestore(BuildContext context, String questionsText) async {
  AppState state = StoreProvider.of<AppState>(context).state;
  FirebaseUser user = state.userData.user;
  Map<String, dynamic> questionsData = {
    "questions": questionsText,
    "user": {
      "userId": user.uid,
      "displayName": user.displayName,
      "profileUrl": user.photoUrl,
      "email": user.email
    },
    "timestamp": FieldValue.serverTimestamp()
  };
  Map<String, dynamic> userData = {'noOfQuestions': FieldValue.increment(1)};
  WriteBatch batch = Firestore.instance.batch();
  DocumentReference questionsDoc = getCollectionDoc("questions");
  DocumentReference userDoc = getUserDoc(user.uid);
  batch.setData(questionsDoc, questionsData);
  batch.updateData(userDoc, userData);
  batch.commit();
}

Future<void> uploadFileToStorage(
    String postId, CreatePostData createPostData) async {
  List<Asset> postImages = createPostData.postImages;
  for (Asset image in postImages) {
    ByteData byteData = await image.requestOriginal(quality: 100);
    Uint8List imageData = byteData.buffer.asUint8List();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String uuid = Uuid().v1();
    String path = "posts/$postId/$uuid/$fileName";
    StorageReference ref = FirebaseStorage.instance.ref().child(path);
    StorageUploadTask uploadTask = ref.putData(imageData);
  }
}

Future<void> addPostToFirestore(String postId, AppState state) async {
  CreatePostData createPostData = state.createPostData;
  FirebaseUser user = state.userData.user;
  Map<String, dynamic> postData = {
    "caption": createPostData.caption,
    "user": {
      "userId": user.uid,
      "email": user.email,
      "photoUrl": user.photoUrl,
      "displayName": user.displayName
    },
    "timestamp": FieldValue.serverTimestamp()
  };
  Map<String, dynamic> userData = {'noOfPosts': FieldValue.increment(1)};
  WriteBatch batch = Firestore.instance.batch();
  DocumentReference postDoc = getDoc("posts/$postId");
  DocumentReference userDoc = getUserDoc(user.uid);
  batch.setData(postDoc, postData);
  batch.updateData(userDoc, userData);
  batch.commit();
}
