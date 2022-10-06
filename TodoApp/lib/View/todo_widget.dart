import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/todos_provider.dart';
import 'package:todo/View/editpage.dart';
import 'package:todo/Model/todos_field.dart';



class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
  required this.todo
  ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)=>ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(todo.id),
        actions: [
          IconSlideAction(
            color: HexColor("#61c589"),
            onTap: () => editTodo(context,todo),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red.withOpacity(0.85),
            caption: 'Delete',
            onTap: ()=>deleteTodo(context,todo),
            icon: Icons.delete,
          )
        ],
        child: buildTodo(context)
    ),
  );

  Widget buildTodo(BuildContext context) =>
      GestureDetector(
        //onTap: ()=>editTodo(context, todo),
        child: Container(
          color: HexColor("#e4edfa"),
          padding: EdgeInsets.fromLTRB(10, 20, 15, 20),
          child: Row(
            children: [
              Checkbox(
                  activeColor: Theme.of(
                      context).primaryColor,
                  checkColor: Colors.white,
                  value: todo.isDone,
                  onChanged: (_){
                    final provider = Provider.of<TodosProvider>(context,listen:false);
                    final isDone = provider.toggleTodoStatus(todo);
                  },
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontFamily: 'assests/poppins/Poppins-SemiBold.ttf'
                        ),
                      ),
                      SizedBox(height: 2),
                      if (todo.description.isNotEmpty)
                        Container(
                         margin: EdgeInsets.only(top: 4),
                         child: Text(
                           todo.description,
                           style: TextStyle(fontSize: 18 ,height: 1.3,
                           fontFamily:'assests/poppins/Poppins-Regular.ttf',
                             color: HexColor("#25262d")
                           ),
                         ),
                        )
                    ],
                  )
              )
            ],
          ),
        ),
      );

  void deleteTodo (BuildContext context,Todo todo)
  {
    final provider = Provider.of<TodosProvider>(context,listen:false);
    provider.removeTodo(todo);
  }

  void editTodo (BuildContext context, Todo todo )=>Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditPage(todo:todo),
    ),
  );
}
