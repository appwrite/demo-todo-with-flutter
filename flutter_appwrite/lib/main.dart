import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/pages/auth_page/loginPage.dart';
import 'package:easy_one/pages/pages_view/homePage.dart';
import 'package:appwrite/models.dart' as models;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easyone',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<models.Account>(
        future: ApiService.instance.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SplashPage();
          if (snapshot.hasData)
            return HomePage(
              user: snapshot.data,
            );
          return LoginPage();
        });
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.headline6.fontSize,
          ),
        ),
      ),
    );
  }
}
