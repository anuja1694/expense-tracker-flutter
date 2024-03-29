import 'package:expense_tracker/Screens/Login.dart';
import 'package:expense_tracker/Screens/register.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(
          onClickedSignUp: toggle,
        )
      : RegisterPage(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
