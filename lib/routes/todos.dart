import 'package:appwrite/appwrite.dart';
import 'package:demo_todo_with_flutter/utilities.dart';
import 'package:flutter/material.dart';

import '../entities/todo.dart';
import '../services/auth.dart';
import '../services/todos.dart';
import '../widgets/todo_list_tile.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final authService = AuthService();
  final todosService = TodosService();
  bool isLoading = true;
  final inputController = TextEditingController();

  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchTodos();
    });
  }

  void fetchTodos() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final result = await todosService.fetch();
      setState(() {
        todos = result;
      });
    } catch (e) {
      messenger.showSnackBar(createErrorSnackBar(e.toString()));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void submitTodo() async {
    if (inputController.text.isEmpty || isLoading) return;
    final messenger = ScaffoldMessenger.of(context);
    final newTodo = Todo(
      content: inputController.text,
      id: ID.unique(),
    );
    todosService.create(todo: newTodo).catchError((e) {
      messenger.showSnackBar(createErrorSnackBar(e.toString()));
      todos.remove(newTodo);
    });
    inputController.text = '';
    setState(() {
      todos.add(newTodo);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );

    const spacing = 10.0;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: spacing,
            right: spacing,
            child: Row(
              children: [
                OutlinedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        await authService.logout();
                        navigator.pop();
                      } catch (e) {
                        messenger
                            .showSnackBar(createErrorSnackBar(e.toString()));
                      }
                    },
                    child: const Text("Logout 👋"))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "📝",
                  style: headlineStyle,
                ),
              ),
              const SizedBox(height: spacing),
              Center(
                child: Text(
                  "toTooooDoooos",
                  style: headlineStyle,
                ),
              ),
              const SizedBox(height: spacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacing * 2),
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  elevation: 5,
                  child: TextField(
                    controller: inputController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) {
                      submitTodo();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(),
                      hintText: '🤔   What to do today?',
                      contentPadding: const EdgeInsets.only(left: 20),
                      suffixIcon: IconButton(
                        onPressed: submitTodo,
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ),
              // if (isLoading)
              //   const Padding(
              //     padding: EdgeInsets.only(top: spacing * 2),
              //     child: Text('Loading ....'),
              //   ),
              if (todos.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: spacing * 2),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: todos.length,
                    prototypeItem: TodoListTile(todo: todos.first),
                    itemBuilder: (context, index) {
                      return TodoListTile(
                        todo: todos[index],
                        toggle: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final messenger = ScaffoldMessenger.of(context);
                          todos[index].isComplete = !todos[index].isComplete;
                          todosService.update(todo: todos[index]).catchError(
                            (e) {
                              // restore value
                              setState(() {
                                todos[index].isComplete =
                                    !todos[index].isComplete;
                              });
                              messenger.showSnackBar(
                                  createErrorSnackBar(e.toString()));
                            },
                          );

                          setState(() {
                            isLoading = false;
                          });
                        },
                        delete: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final messenger = ScaffoldMessenger.of(context);
                          final todo = todos[index];
                          todosService.delete(id: todo.id).catchError((e) {
                            // restore value
                            setState(() {
                              todos.insert(index, todo);
                            });
                            messenger.showSnackBar(
                                createErrorSnackBar(e.toString()));
                          });
                          setState(() {
                            todos.removeAt(index);
                            isLoading = false;
                          });
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
