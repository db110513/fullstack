import 'package:flutter/material.dart';
import '../screens/sign_up.dart';
import '../styles/app_styles.dart';

class ToSignUp extends StatelessWidget {
  const ToSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUp()),
        );
      },
      child: const Text('No tens compte?', style: AppStyles.noCompta,),
    );
  }
}
