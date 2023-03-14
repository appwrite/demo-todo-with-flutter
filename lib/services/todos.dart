import 'package:appwrite/appwrite.dart';

import '../constants.dart' as constants;
import '../entities/todo.dart';
import '../services/appwrite.dart';

class TodosService {
  final Databases _databases = Databases(Appwrite.instance.client);

  Future<List<Todo>> fetch() async {
    final documentList = await _databases.listDocuments(
      databaseId: constants.appwriteDatabaseId,
      collectionId: constants.appwriteCollectionId,
    );
    return documentList.documents.map((d) => Todo.fromMap(d.data)).toList();
  }

  Future<Todo> create({required Todo todo}) async {
    final document = await _databases.createDocument(
      databaseId: constants.appwriteDatabaseId,
      collectionId: constants.appwriteCollectionId,
      documentId: todo.id,
      data: {"content": todo.content, "isComplete": todo.isComplete},
    );

    return Todo.fromMap(document.data);
  }

  Future<Todo> update({required Todo todo}) async {
    final document = await _databases.updateDocument(
      databaseId: constants.appwriteDatabaseId,
      collectionId: constants.appwriteCollectionId,
      documentId: todo.id,
      data: todo.toMap(),
    );

    return Todo.fromMap(document.data);
  }

  Future<void> delete({required String id}) async {
    return _databases.deleteDocument(
      databaseId: constants.appwriteDatabaseId,
      collectionId: constants.appwriteCollectionId,
      documentId: id,
    );
  }
}
