import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gdgflutterdemo/config/application.dart';

class VideoIncomingScreen extends StatelessWidget {
  final String channelId;
  final String userId;

  const VideoIncomingScreen({Key key, this.channelId, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GDG Flutter Demo Video Call'),
      ),
      body: FutureBuilder(
        future: Firestore.instance.document('users/$userId').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error ...'),
              );
            } else {
              DocumentSnapshot currentDocument = snapshot.data;
              String photoUrl = currentDocument.data['profile']['photoUrl'];
              String displayName = currentDocument.data['displayName'];
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        maxRadius: 70,
                        backgroundImage: CachedNetworkImageProvider(photoUrl),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Text(
                      '$displayName is calling you!!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                    ),
                    RaisedButton(
                      child: Text('Accept'),
                      onPressed: () {
                        String path = '/goToVideoCall/$channelId';
                        Application.router.navigateTo(context, path,
                            transition: TransitionType.nativeModal);
                      },
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
