import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:todo/Model/todos_field.dart';
import 'package:todo/Provider/todos_provider.dart';
import 'package:todo/View/todo_form_edit.dart';

class EditPage extends StatefulWidget {

  final Todo todo;
  const EditPage({Key? key,required this.todo}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;

  @override
  void initState()
  {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),

          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(child: Text('Edit Todo',
          style: TextStyle(
              fontFamily: 'assests/product/Product Sans Bold.ttf',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: HexColor("#25262d")
          ),
          )),
          actions: [
            IconButton(
                onPressed: (){
                  final provider = Provider.of<TodosProvider>(context,listen:false);
                  provider.removeTodo(widget.todo);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.delete),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  color: Colors.lightBlue,
                  offset: Offset(0,0),
                  blurRadius: 5,
                  spreadRadius: 1
                )]
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: TodoFormEdit(
                    title : title,
                    description : description,
                    onChangedTitle: (title)=>setState(()=>
                    this.title = title),
                    onChangedDescription: (description)=>setState(()=>
                    this.description=description),
                    onSavedTodo: saveTodo,
                    ),
                ),
              ),
            ),
          ),
        ),
       );

  void saveTodo()
  {
    final isValid = _formKey.currentState!.validate();

    if(!isValid)
      {
        return ;
      }
    else{
      final provider = Provider.of<TodosProvider>(context,listen:false);
      provider.updateTodo(widget.todo,title,description);
      Navigator.of(context).pop();
    }
  }
}
