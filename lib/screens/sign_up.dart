import 'package:flutter/material.dart';
import '../widgets/signup_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  Widget build(BuildContext context) {
    return SignUpWidget();
  }
}