import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config.dart';

final appWriteProvider = Provider<Client>((ref) {
  return Client(selfSigned: kDebugMode)
    ..setEndpoint(Config.endPoint)
    ..setProject(Config.project);
});
