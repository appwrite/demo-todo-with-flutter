import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../animations/hover_lift.dart';
import '../authentication/authentication_provider.dart';
import 'todo_list_provider.dart';
import 'todo_model.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _todoProvider = watch(todoProvider);
    return Scaffold(
      body: CustomScrollView(
        anchor: .2,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "📝\ntoTooooDoooos",
                  style: Theme.of(context) //
                      .textTheme
                      .headline2
                      ?.copyWith(height: 2.1.h),
                  textAlign: TextAlign.center,
                ),
                const _TextBoxWidget(),
              ],
            ),
          ),
          _todoProvider.when(
            data: (todos) => SliverList(
                delegate: SliverChildBuilderDelegate(
              (_, index) {
                return ProviderScope(
                  overrides: [
                    scopedTodo.overrideWithValue(todos[index]),
                  ],
                  child: const _TodoWidget(),
                );
              },
              childCount: todos.length,
            )),
            loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, st) => const SliverToBoxAdapter(
              child: Center(child: Text("Something went wrong")),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(50.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          ),
          onPressed: () {
            context.read(authProvider.notifier).logout();
          },
          child: const Text(
            "Logout👋",
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class _TextBoxWidget extends StatefulWidget {
  const _TextBoxWidget({Key? key}) : super(key: key);

  @override
  __TextBoxWidgetState createState() => __TextBoxWidgetState();
}

class __TextBoxWidgetState extends State<_TextBoxWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: width < 900
                ? const BoxConstraints(minWidth: 100, maxWidth: 230)
                : const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 400,
                  ),
            child: HoverLift(
              child: PhysicalModel(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                elevation: 8,
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  onSubmitted: (value) async {
                    await context
                        .read(todoProvider.notifier)
                        .createTodo(TodoModel(
                          content: value,
                          isCompleted: false,
                        ));

                    _controller.clear();
                  },
                  decoration: InputDecoration(
                    hintText: "🤔   What to do today?",
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoWidget extends ConsumerWidget {
  const _TodoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final width = MediaQuery.of(context).size.width;
    final todo = watch(scopedTodo);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: width < 900
                ? const BoxConstraints(minWidth: 100, maxWidth: 230)
                : const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 400,
                  ),
            child: Row(
              children: <Widget>[
                HoverLift(
                  endScale: 1.25,
                  child: Transform.scale(
                    scale: 1.4.sp,
                    child: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        context.read(todoProvider.notifier).updateTodo(
                              todo.copyWith(
                                isCompleted: !todo.isCompleted,
                              ),
                            );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    todo.content,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 18.sp,
                      decoration:
                          todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                HoverLift(
                  endScale: 1.25,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    iconSize: 30.sp,
                    hoverColor: Colors.transparent,
                    onPressed: () {
                      context.read(todoProvider.notifier).deleteTodo(todo);
                    },
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
