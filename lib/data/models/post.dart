import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdgflutterdemo/data/models/user_data.dart';
import 'package:gdgflutterdemo/util/helper.dart';

class Post {
  String caption;
  String postId;
  User user;
  List<PostImage> postImages;

  Post(this.postId, this.caption, this.user, {this.postImages});

  Post.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    this.postId = snapshot.documentID;
    this.caption = data['caption'];
    Map<String, dynamic> userMapData = convertToStringMap(data['user']);
    this.user = User.fromPostMap(userMapData);
    if (data['images'] != null) {
      Map<String, dynamic> imagesMapData = convertToStringMap(data['images']);
      List<String> imageIds = imagesMapData.keys.toList();
      this.postImages = imageIds.map((String imageKeys) {
        Map<String, dynamic> currentImageData =
            convertToStringMap(imagesMapData[imageKeys]);
        PostImage postImage =
            PostImage.fromPostMap(currentImageData, imageKeys);
        return postImage;
      }).toList();
    }
  }
}

class PostImage {
  String postImageId;
  int likeCount;
  String imageUrl;
  PostImage({this.postImageId, this.imageUrl, this.likeCount});

  PostImage.fromPostMap(Map<String, dynamic> data, String key) {
    this.postImageId = key;
    this.likeCount = data['likeCount'];
    this.imageUrl = data['photoUrl'];
  }
}
