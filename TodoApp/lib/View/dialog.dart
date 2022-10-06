import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/View/todo_form.dart';
import 'package:todo/Model/todos_field.dart';
import 'package:todo/Provider/todos_provider.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) =>AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Todo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          TodoForm(
            onChangedTitle : (title) => setState(()=>this.title = title),
            onChangedDescription : (description) => setState(()=>this.description = description),
            onSavedTodo: addTodo,
          )
        ],
      ),
    ),
  );

  void addTodo()
  {
    final isValid = _formKey.currentState!.validate();

    if(!isValid)
      {
        return;
      }
    else
    {
      final todo = Todo(
        id:DateTime.now().toString(),
        title:title,
        description:description,
        createdTime : DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context,listen:false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
