import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get endPoint => env["FLUTTER_APP_ENDPOINT"] ?? "";
  static String get project => env["FLUTTER_APP_PROJECT"] ?? "";
  static String get collectionId => env["FLUTTER_APP_COLLECTION_ID"] ?? "";
}
