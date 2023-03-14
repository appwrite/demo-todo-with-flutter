import 'package:appwrite/appwrite.dart';

import '../constants.dart' as constants;

class Appwrite {
  static final Appwrite instance = Appwrite._internal();

  late final Client client;

  factory Appwrite._() {
    return instance;
  }

  Future<void> initialize() {
    return client.setOfflinePersistency(
      status: true,
      onWriteQueueError: (e) {
        print(e);
      },
    );
  }

  Appwrite._internal() {
    client = Client()
        .setEndpoint(constants.appwriteEndpoint)
        .setProject(constants.appwriteProjectId)
        .setSelfSigned(status: constants.appwriteSelfSigned)
        .setOfflineCacheSize(2500);
  }
}
