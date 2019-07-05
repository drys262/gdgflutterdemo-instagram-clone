import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String createPost = "/createPost";
  static String goToVideoCall = "/goToVideoCall/:channelId";
  static String goToIncomingVideo = "/goToIncomingVideo/:channelId/:userId";

  static void configureRoutes(Router router) {
    router.define(root, handler: rootHandler);
    router.define(createPost, handler: createPostHandler);
    router.define(goToVideoCall, handler: goToVideoCallHandler);
    router.define(goToIncomingVideo, handler: goToIncomingVideoCallHandler);
  }
}
