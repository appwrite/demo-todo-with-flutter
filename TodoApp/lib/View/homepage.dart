import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/todos_provider.dart';
import 'package:todo/View/dialog.dart';
import 'package:todo/api/firebase_api.dart';
import 'package:todo/View/completed_list.dart';

import 'package:todo/main.dart';
import 'package:todo/View/todo_list_widget.dart';
import 'package:todo/Model/todos_field.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {

    final tabs = [
      TodoListWidget(),
      CompletedListWidget()
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
            child: Column(
              children :[
                Text('Todo',
                style: TextStyle(
                fontFamily: 'assests/product/Product Sans Bold.ttf',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: HexColor("#25262d")
              )
              ),
              SizedBox(height: 5),
                Text("It always seems impossible until it's done",style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'assests/poppins/Poppins-Regular.ttf',
                  color: Colors.grey,
                  fontWeight: FontWeight.w400
                ),)
              ]
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: StreamBuilder<List<Todo>>(
          stream: FirebaseApi.readTodos(),
          builder: (context,snapshot)
          {
            switch(snapshot.connectionState)
            {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if(snapshot.hasError)
                  {
                    return Text('Something went wrong, Try later');
                  }
                else
                  {
                    final todos = snapshot.data;
                    final provider = Provider.of<TodosProvider>(context);
                    provider.setTodos(todos!);
                    return tabs[selectedIndex];
                  }
            }
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor:Colors.black12.withOpacity(0.7),
        selectedItemColor: Colors.lightBlue,
        currentIndex: selectedIndex,
        onTap: (index)=>setState(() {
          selectedIndex=index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              label: 'Todos'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done,size: 28),
              label: 'Completed'
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.lightBlue,
        onPressed: () => showDialog(
          builder: (context) => AddDialog(), context: context,
          barrierDismissible: false,
        ),
        child: Icon(Icons.add,color: Colors.white,size: 25),
      ),
    );
  }
}
