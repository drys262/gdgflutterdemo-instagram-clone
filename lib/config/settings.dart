import 'package:flutter_dotenv/flutter_dotenv.dart';

String getAppId() => DotEnv().env['APP_ID'];
