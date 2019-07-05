import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String createPost = "/createPost";

  static void configureRoutes(Router router) {
    router.define(root, handler: rootHandler);
    router.define(createPost, handler: createPostHandler);
  }
}
