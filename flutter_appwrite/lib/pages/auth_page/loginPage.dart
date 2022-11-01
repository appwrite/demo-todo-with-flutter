import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/main.dart';
import 'package:easy_one/pages/auth_page/signupPage.dart';
import 'package:easy_one/widget/elevatedButton_widget.dart';
import 'package:easy_one/widget/routeHelper.dart';
import 'package:easy_one/widget/textButton.dart';
import 'package:easy_one/widget/textFormField_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/model/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user;
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.indigo.withOpacity(0.6),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.09,
              ),
              Container(
                height: size.height * 0.3,
                width: size.width,
                child: SvgPicture.asset('assets/four.svg'),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              textFormField(
                textColor: Colors.white,
                controller: _email,
                validator: (val) {
                  if (val.isEmpty) return 'Email can\'t be empty';
                  return null;
                },
                hintText: 'enter your email',
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              textFormField(
                textColor: Colors.white,
                obscureText: true,
                validator: (val) {
                  if (val.isEmpty) return 'Password can\'t be empty';
                  if (val.length < 8) return 'Password length is not matched';
                  return null;
                },
                controller: _password,
                hintText: 'enter your password',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              elevatedButton(
                context,
                "Login",
                size: Size(size.width, size.height * 0.06),
                onPressed: () async {
                  var email = _email.text;
                  var password = _password.text;
                  if (_globalKey.currentState.validate()) {
                    try {
                      final user = await ApiService.instance
                          .login(email: email, password: password);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Welcome to EasyOne"),
                        ),
                      );
                      _password.clear();
                      _email.clear();
//                       print(user);
                      pushReplacement(context, MainPage());
                    } on AppwriteException catch (e) {
                      // print(e);
                      print(e.message);
                      _password.clear();
                      _email.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message),
                        ),
                      );
                    }
                  } else {
                    print("not validate");
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              textButton(
                'Don\'t have an account?  SignUp',
                onPressed: () {
                  push(context, SignUp());
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
