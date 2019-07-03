import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String createPoll = "/createPoll";

  static void configureRoutes(Router router) {
    router.define(root, handler: rootHandler);
    router.define(createPoll, handler: createPollHandler);
  }
}
