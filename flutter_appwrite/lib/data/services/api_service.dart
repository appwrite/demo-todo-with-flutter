import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:easy_one/data/model/addData_model.dart';
import 'package:easy_one/data/model/user_model.dart';

import 'package:easy_one/res/constant.dart';

class ApiService {
  static ApiService _instance;

  Client _client;
  Account _account;
  Database _db;
  Storage _storage;

  ApiService._internal() {
    _client = Client(endPoint: AppConstant.endPoint)
        .setProject(AppConstant.projectid)
        .setSelfSigned();
    _account = Account(_client);
    _db = Database(_client);
    _storage = Storage(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future login({String email, String password}) {
    return _account.createSession(email: email, password: password);
  }

  Future signup({String name, String email, String password}) {
    return _account.create(name: name, email: email, password: password);
  }

  Future updateanylogin({String email, String password}) {
    return _account.updateEmail(email: email, password: password);
  }

  Future logout() {
    return _account.deleteSession(sessionId: 'current');
  }

  Future<User> getUser() async {
    final res = await _account.get();
    return User.fromMap(res.data);
  }

  Future<AddData> getAddData({
    AddData addData,
    List<String> read,
    List<String> write,
  }) async {
    final res = await _db.createDocument(
      collectionId: AppConstant.database,
      data: addData.toMap(),
      read: read,
      write: write,
    );
    return AddData.fromMap(res.data);
  }

  Future<List<AddData>> insertData() async {
    final res = await _db.listDocuments(
      // offset: 100,
      limit: 100,
      collectionId: AppConstant.database,
    );
    return List<Map<String, dynamic>>.from(res.data['documents'])
        .map((e) => AddData.fromMap(e))
        .toList();
  }

  Future deleteData({String documentId}) async {
    return await _db.deleteDocument(
        collectionId: AppConstant.database, documentId: documentId);
  }

  Future<AddData> editData({
    String documentId,
    AddData addData,
    List<String> read,
    List<String> write,
  }) async {
    final res = await _db.updateDocument(
      collectionId: AppConstant.database,
      documentId: documentId,
      data: addData.toMap(),
      read: read,
      write: write,
    );

    return AddData.fromMap(res.data);
  }

  Future<Map<String, dynamic>> uploadPicture(
    MultipartFile file,
    List<String> permission,
  ) async {
    var res = await _storage.createFile(
      file: file,
      read: permission,
      write: permission,
    );
    return res.data;
  }

  Future<Map<String, dynamic>> updatePrefs(Map<String, dynamic> prefs) async {
    final res = await _account.updatePrefs(prefs: prefs);
    return res.data;
  }

  Future<Uint8List> getProfile(String fileId) async {
    final res = await _storage.getFilePreview(fileId: fileId);
    return res.data;
  }
}
