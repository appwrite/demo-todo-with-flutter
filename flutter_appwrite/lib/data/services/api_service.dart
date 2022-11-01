import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:easy_one/data/model/addData_model.dart';
import 'package:easy_one/data/model/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:easy_one/res/constant.dart';

class ApiService {
  static ApiService _instance;
  Client _client;
  Account _account;
  Databases _db;
  Storage _storage;

  ApiService._internal() {
    _client = Client(endPoint: AppConstant.endPoint)
        .setProject(AppConstant.projectid)
        .setSelfSigned();
    _account = Account(_client);
    _db = Databases(_client);
    _storage = Storage(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance;
  }

  Future login({String email, String password}) {
    return _account.createEmailSession(email: email, password: password);
  }

  Future signup({String name, String email, String password}) {
    return _account.create(name: name, email: email, password: password, userId: email);
  }

  Future updateanylogin({String email, String password}) {
    return _account.updateEmail(email: email, password: password);
  }

  Future logout() {
    return _account.deleteSession(sessionId: 'current');
  }

  Future<User> getUser() async {
    final res = await _account.get();
    return User.fromMap(res.toMap());
  }

  Future<AddData> getAddData({
    AddData addData,
    List<String> read,
    List<String> write,
  }) async {
    final res = await _db.createDocument(
      collectionId: AppConstant.collectionId,
      data: addData.toMap(),
      // read: read,
      // write: write,
      permissions: [
        'read',
        'write',
      ],
      databaseId: AppConstant.database,
      documentId: addData.id,

    );
    return AddData.fromMap(res.data);
  }

  Future<List<AddData>> insertData() async {
    final res = await _db.listDocuments(
      // offset: 100,
      // limit: 100,
      collectionId: AppConstant.collectionId,
        databaseId: AppConstant.database,
    );
    return List<Map<String, dynamic>>.from(res.toMap()['documents'])
        .map((e) => AddData.fromMap(e))
        .toList();
  }

  Future deleteData({String documentId}) async {
    return await _db.deleteDocument(
        collectionId: AppConstant.database, documentId: documentId, databaseId: AppConstant.database);
  }

  Future<AddData> editData({
    String documentId,
    AddData addData,
    List<String> read,
    List<String> write,
  }) async {
    final res = await _db.updateDocument(
      collectionId: AppConstant.database,
      databaseId: AppConstant.database,
      documentId: documentId,
      data: addData.toMap(),
      permissions: [
        'read',
        'write',
      ],
    );

    return AddData.fromMap(res.data);
  }

  Future<Map<String, dynamic>> uploadPicture(
      file,
    List<String> permission,
  ) async {
    var res = await _storage.createFile(
      bucketId: AppConstant.bucketId,
      file: file,
      permissions: permission,
      fileId: file.name,
    );
    return res.toMap();
  }

  Future<Map<String, dynamic>> updatePrefs(Map<String, dynamic> prefs) async {
    final res = await _account.updatePrefs(prefs: prefs);
    return res.toMap();
  }

  Future<Uint8List> getProfile(String fileId) async {
    final res = await _storage.getFilePreview(fileId: fileId, bucketId: AppConstant.bucketId);
    return res.toList();
  }
}
