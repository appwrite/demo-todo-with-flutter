import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_one/data/services/api_service.dart';
import 'package:easy_one/widget/elevatedButton_widget.dart';
import 'package:easy_one/widget/routeHelper.dart';
import 'package:easy_one/widget/textButton.dart';
import 'package:easy_one/widget/textFormField_widget.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  TextEditingController _username = TextEditingController();
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
                height: size.height * 0.21,
                width: size.width,
                child: SvgPicture.asset('assets/signup.svg'),
              ),
              SizedBox(
                height: size.height * 0.033,
              ),
              textFormField(
                textColor: Colors.white,
                keyboardType: TextInputType.name,
                validator: (val) {
                  if (val.isEmpty) return 'Name can\'t be empty';
                  return null;
                },
                controller: _username,
                hintText: 'enter your full name',
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              textFormField(
                textColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val.isEmpty) return 'Email can\'t be empty';
                  if (!val.contains('@')) return 'Email is invalid';
                  return null;
                },
                controller: _email,
                hintText: 'enter your email',
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              textFormField(
                textColor: Colors.white,
                obscureText: true,
                validator: (val) {
                  if (val.isEmpty) return "Pasword can't be empty";
                  if (val.length < 8) return "Password is more than 8 letter";
                  return null;
                },
                keyboardType: TextInputType.name,
                controller: _password,
                hintText: 'enter your password',
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              elevatedButton(
                context,
                "Create an Account",
                size: Size(size.width, size.height * 0.06),
                onPressed: () {
                  var name = _username.text;
                  var email = _email.text;
                  var password = _password.text;
                  if (_globalKey.currentState.validate()) {
                    try {
                      ApiService.instance
                          .signup(name: name, email: email, password: password);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Succesfully Register"),
                        ),
                      );
                      _password.clear();
                      _username.clear();
                      _email.clear();
                      pop(context);
                    } on AppwriteException catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              textButton(
                'If you have an account?  Login',
                onPressed: () {
                  pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
