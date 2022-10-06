import 'package:flutter/material.dart';

class TodoFormEdit extends StatelessWidget {

  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;


  const TodoFormEdit({Key? key,
    this.title='',
    this.description='',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 20),
          buildDescription(),
          SizedBox(height:50 ),
          buildButton(),
        ],
      ),
    );
  }
  Widget buildTitle() => TextFormField(
    maxLines: 1 ,
    initialValue: title,
    onChanged: onChangedTitle,
    validator: (title)
    {
      if(title!.isEmpty)
        {
          return 'The title cannot be empty';
        }
      return null;
    },
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Title',
      labelStyle: TextStyle(
        color: Colors.lightBlue,
        fontSize: 18,
        fontFamily: 'assests/product/Product Sans Bold.ttf'
      )
    ),
  );

  Widget buildDescription() => TextFormField(
    maxLines: 14 ,
    initialValue: description,
    onChanged: onChangedDescription,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Description',
        labelStyle: TextStyle(
            color: Colors.lightBlue,
            fontSize: 18,
            fontFamily: 'assests/product/Product Sans Bold.ttf'
        )
    ),
  );

  Widget buildButton()=>SizedBox(
    width: double.infinity,
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
        ),
        onPressed: onSavedTodo,
        child: Text('Save')
    ),
  );
}
