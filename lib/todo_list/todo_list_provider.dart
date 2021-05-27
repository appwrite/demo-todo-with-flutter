import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_appwrite/config.dart';

import '../authentication/authentication_provider.dart';
import '../shared/appwrite_provider.dart';
import 'todo_model.dart';

typedef TodoValue = AsyncValue<List<TodoModel>>;
typedef TodoData = AsyncData<List<TodoModel>>;
typedef TodoLoading = AsyncLoading<List<TodoModel>>;
typedef TodoError = AsyncError<List<TodoModel>>;

final scopedTodo = ScopedProvider<TodoModel>(null);

final todoProvider = StateNotifierProvider<TodoProvider, TodoValue>((ref) {
  return TodoProvider(ref.read);
});

class TodoProvider extends StateNotifier<TodoValue> {
  TodoProvider(Reader read)
      : _service = read(_todoService),
        super(const TodoLoading()) {
    _init();
  }

  final _TodoService _service;
  Future<void> _init() async {
    final data = await _service.listTodos();
    if (data != null)
      state = TodoData(data);
    else
      state = TodoError("Something went wrong");
  }

  Future<void> createTodo(TodoModel model) async {
    final oldTodos = state.data!.value;
    state = const TodoLoading();
    final data = await _service.createTodo(model);
    if (data != null)
      state = TodoData([data, ...oldTodos]);
    else
      state = TodoError("Something went wrong");
  }

  Future<void> updateTodo(TodoModel model) async {
    final oldTodos = state.data!.value;
    state = const TodoLoading();
    final data = await _service.updateTodo(model);

    if (data != null) {
      final index = oldTodos.indexWhere(
        (m) => model.documentId == m.documentId,
      );
      oldTodos[index] = data;

      state = TodoData(oldTodos);
    } else
      state = TodoError("Something went wrong");
  }

  Future<void> deleteTodo(TodoModel model) async {
    final oldTodos = state.data!.value;
    state = const TodoLoading();
    final data = await _service.deleteTodo(model);
    if (data != null && data) {
      final index = oldTodos.indexOf(model);
      oldTodos.removeAt(index);
      state = TodoData(oldTodos);
    } else
      state = TodoError("Something went wrong");
  }
}

final _todoService = Provider<_TodoService>((ref) {
  final userId = ref.watch(authProvider);
  return _TodoService(ref.read, userId!);
});

class _TodoService {
  _TodoService(Reader read, String userId)
      : _database = Database(read(appWriteProvider)),
        _userId = userId;
  final Database _database;
  final String _userId;

  Future<TodoModel?> createTodo(TodoModel model) async {
    try {
      final result = await _database.createDocument(
        collectionId: Config.collectionId,
        data: model.toMap(),
        read: ["user:$_userId"],
        write: ["user:$_userId"],
      );
      if (result.statusCode == 201) {
        return TodoModel.fromMap(result.data as Map<String, dynamic>);
      }
    } on AppwriteException catch (err) {
      debugPrint(err.response.toString());
    }
  }

  Future<List<TodoModel>?> listTodos() async {
    try {
      final result = await _database.listDocuments(
        collectionId: Config.collectionId,
      );
      if (result.statusCode == 200) {
        final documents = result.data['documents'] as List;

        return documents
            .map((e) => TodoModel.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    } on AppwriteException catch (err) {
      debugPrint(err.response.toString());
    }
  }

  Future<TodoModel?> updateTodo(TodoModel update) async {
    try {
      final result = await _database.updateDocument(
        collectionId: Config.collectionId,
        data: update.toMap(),
        documentId: update.documentId!,
        read: ["user:$_userId"],
        write: ["user:$_userId"],
      );
      if (result.statusCode == 200) {
        return TodoModel.fromMap(result.data as Map<String, dynamic>);
      }
    } on AppwriteException catch (err) {
      debugPrint(err.response.toString());
    }
  }

  Future<bool?> deleteTodo(TodoModel update) async {
    try {
      final result = await _database.deleteDocument(
        collectionId: Config.collectionId,
        documentId: update.documentId!,
      );
      if (result.statusCode == 204) {
        return true;
      }
    } on AppwriteException catch (err) {
      debugPrint(err.response.toString());
      return false;
    }
  }
}
