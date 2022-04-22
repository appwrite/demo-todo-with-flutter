import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/appwrite_provider.dart';

final authServiceProvider = Provider<_AuthService>((ref) {
  return _AuthService(ref.read(appWriteProvider));
});

final authProvider = StateNotifierProvider<AuthProvider, String?>((ref) {
  return AuthProvider(ref.read);
});

class AuthProvider extends StateNotifier<String?> {
  AuthProvider(Reader read) : super(null) {
    _authService = read(authServiceProvider);
    _init();
  }

  late _AuthService _authService;

  Future<void> _init() async {
    try {
      final user = await _authService.getAccount();
      state = user.$id;
    } on AppwriteException catch (e) {
      debugPrint(
        "message:${e.message}, code:${e.code}, response:${e.response}",
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _authService.createSession(email: email, password: password);
    final user = await _authService.getAccount();
    state = user.$id;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await _authService.createAccount(
        email: email,
        password: password,
        name: name,
      );
      await login(email: email, password: password);
    } on AppwriteException catch (e) {
      debugPrint(
        "message:${e.message}, code:${e.code}, response:${e.response}",
      );
    }
  }

  Future<void> logout() async {
    final result = await _authService.deleteCurrentSession();
    if (result.statusCode == 204) {
      state = null;
    }
  }
}

class _AuthService {
  _AuthService(Client client) : _account = Account(client);
  final Account _account;

  Future<User> createAccount({
    required String email,
    required String password,
    required String name,
  }) {
    return _account.create(
        userId: 'unique()', email: email, password: password, name: name);
  }

  Future<User> getAccount() {
    return _account.get();
  }

  Future<Session> createSession({
    required String email,
    required String password,
  }) {
    return _account.createSession(email: email, password: password);
  }

  Future<dynamic> deleteCurrentSession() {
    return _account.deleteSession(sessionId: "current");
  }
}
