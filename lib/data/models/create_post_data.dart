import 'package:multi_image_picker/multi_image_picker.dart';

class CreatePostData {
  List<Asset> postImages;
  String caption;

  CreatePostData(this.postImages, this.caption);
}
