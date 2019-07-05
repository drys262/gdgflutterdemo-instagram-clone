import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gdgflutterdemo/data/models/post.dart';

class FeedCarousel extends StatelessWidget {
  final List<PostImage> postImages;

  const FeedCarousel({Key key, this.postImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return postImages != null
        ? CarouselSlider(
            autoPlay: false,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            height: 400,
            items: postImages.map(
              (postImage) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onDoubleTap: () {
                      print("ON DOUBLE TAP HERE");
                      print(postImage.postImageId);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                      child: CachedNetworkImage(
                        imageUrl: postImage.imageUrl,
                        fit: BoxFit.cover,
                        width: 1000.0,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          )
        : Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Colors.white,
                height: 300,
                width: 300,
              ),
            ),
          );
  }
}
