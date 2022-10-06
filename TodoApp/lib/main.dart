import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/todos_provider.dart';
import 'package:todo/View/homepage.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final String title = "Todo App";

  @override
  Widget build(BuildContext context)=>ChangeNotifierProvider(
      create: (context) =>TodosProvider(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          scaffoldBackgroundColor:HexColor("#FFf6f5ee"),
        ),
        home: HomePage(),
      )
  );
}