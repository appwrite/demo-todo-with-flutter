import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_provider.dart';
import 'widgets/inverted_color_button.dart';
import 'widgets/label_text_field.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLogin = true, enableButton = false;

  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: width < 900
            ? const EdgeInsets.only(left: 50)
            : const EdgeInsets.only(left: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isLogin ? "Login" : "Sign Up",
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  isLogin
                      ? "Don't have an account ? "
                      : "Already have an account ? ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin ? "Sign up" : "Login",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: width < 550 ? width - 70 : 500,
              child: Column(
                children: [
                  if (!isLogin)
                    LabelTextField(
                      key: const ValueKey("name"),
                      label: "Name",
                      controller: _nameController,
                      onChanged: (_) {
                        setState(() {
                          enableButton = isAllBoxFilled;
                        });
                      },
                    ),
                  LabelTextField(
                    key: const ValueKey("email"),
                    label: "Email",
                    controller: _emailController,
                    onChanged: (_) {
                      setState(() {
                        enableButton = isAllBoxFilled;
                      });
                    },
                  ),
                  LabelTextField(
                    key: const ValueKey("password"),
                    label: "Password",
                    controller: _passwordController,
                    isPassword: true,
                    onChanged: (_) {
                      setState(() {
                        enableButton = isAllBoxFilled;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            InvertedColorButton(
              text: isLogin ? "Login" : "Sign Up",
              onPressed: enableButton ? () => _onButtonPressed() : null,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onButtonPressed() async {
    if (isLogin)
      await _login();
    else
      await _signUp();
  }

  Future<void> _login() async {
    return context.read(authProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  Future<void> _signUp() async {
    return context.read(authProvider.notifier).signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  bool get isAllBoxFilled =>
      (isLogin || _nameController.text.isNotEmpty) &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;
}
