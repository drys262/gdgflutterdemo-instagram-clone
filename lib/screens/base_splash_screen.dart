import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class BaseSplashScreen extends StatelessWidget {
  final Widget navigateTo;

  BaseSplashScreen({Key key, this.navigateTo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: this.navigateTo,
        image: Image.asset('assets/images/sample-logo.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.white);
  }
}
