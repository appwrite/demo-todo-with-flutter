import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get endPoint => dotenv.env["FLUTTER_APP_ENDPOINT"] ?? "";
  static String get project => dotenv.env["FLUTTER_APP_PROJECT"] ?? "";
  static String get collectionId =>
      dotenv.env["FLUTTER_APP_COLLECTION_ID"] ?? "";
}
