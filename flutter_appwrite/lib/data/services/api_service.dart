import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:easy_one/data/model/addData_model.dart';

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
    return _account.create(
        name: name, email: email, password: password, userId: ID.unique());
  }

  Future updateanylogin({String email, String password}) {
    return _account.updateEmail(email: email, password: password);
  }

  Future logout() {
    return _account.deleteSession(sessionId: 'current');
  }

  Future<models.Account> getUser() async {
    return _account.get();
  }

  Future<AddData> getAddData({
    AddData addData,
    List<String> permissions,
  }) async {
    final res = await _db.createDocument(
      databaseId: AppConstant.database,
      collectionId: AppConstant.collection,
      documentId: ID.unique(),
      data: addData.toMap(),
      permissions: permissions,
    );
    return AddData.fromMap(res.data);
  }

  Future<List<AddData>> insertData() async {
    final res = await _db.listDocuments(
        databaseId: AppConstant.database,
        collectionId: AppConstant.collection,
        queries: [Query.limit(100)]);

    return res.documents.map((e) => AddData.fromMap(Map.from(e.data))).toList();
  }

  Future deleteData({String documentId}) async {
    return await _db.deleteDocument(
        databaseId: AppConstant.database,
        collectionId: AppConstant.collection,
        documentId: documentId);
  }

  Future<AddData> editData({
    String documentId,
    AddData addData,
    List<String> permissions,
  }) async {
    final res = await _db.updateDocument(
      databaseId: AppConstant.database,
      collectionId: AppConstant.collection,
      documentId: documentId,
      data: addData.toMap(),
      permissions: permissions,
    );

    return AddData.fromMap(res.data);
  }

  Future<models.File> uploadPicture(
    InputFile file,
    List<String> permission,
  ) async {
    var res = await _storage.createFile(
      bucketId: AppConstant.bucket,
      fileId: ID.unique(),
      file: file,
      permissions: permission,
    );
    return res;
  }

  Future<models.Account> updatePrefs(Map<String, dynamic> prefs) async {
    return _account.updatePrefs(prefs: prefs);
  }

  Future<Uint8List> getProfile(String fileId) async {
    return _storage.getFilePreview(
        fileId: fileId, bucketId: AppConstant.bucket);
  }
}
