
import 'package:flutter/cupertino.dart';
import 'package:todo/api/firebase_api.dart';
import 'package:todo/Model/todos_field.dart';

class TodosProvider extends ChangeNotifier
{
  List<Todo> _todos = [];

  //To make it public and show on todos navigation
  List<Todo> get todos => _todos.where((todo) =>todo.isDone==false).toList();
  List<Todo> get todosCompleted => _todos.where((todo) =>todo.isDone==true).toList();

  void addTodo(Todo todo)=>
      FirebaseApi.createTodo(todo);


  void removeTodo(Todo todo)
  {
    FirebaseApi.deleteTodo(todo);
  }

  bool toggleTodoStatus(Todo todo)
  {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description)
  {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }

  void setTodos(List<Todo> todos)
  {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _todos = todos;
      notifyListeners();
    });
  }
}