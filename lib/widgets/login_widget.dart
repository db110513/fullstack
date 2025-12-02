import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reus_deportiu/widgets/to_signup.dart';
import '../styles/app_styles.dart';
import '../screens/menu.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _login() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      if (userCredential.user != null) {
        _showSnackBar('Sessió iniciada correctament!');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
      }
    } catch (e) {
      _showSnackBar('Error a l\'iniciar sessió: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hola!', style: AppStyles.logInTitle),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Contrasenya',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Inicia Sessió'),
            ),
            AppStyles.sizedBoxHeight60,
            const ToSignUp()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

}
