import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

import '../services/appwrite.dart';

class AuthService {
  final Account _account = Account(Appwrite.instance.client);

  Future<models.Account> signUp(
      {String? name, required String email, required String password}) async {
    await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
    return login(email: email, password: password);
  }

  Future<models.Account> login(
      {required String email, required String password}) async {
    await _account.createEmailSession(
      email: email,
      password: password,
    );
    return _account.get();
  }

  Future<void> logout() {
    return _account.deleteSession(sessionId: 'current');
  }
}
