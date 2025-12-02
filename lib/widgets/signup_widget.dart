import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Afegit import Firestore
import 'package:reus_deportiu/styles/app_styles.dart';

import '../screens/menu.dart';

class SignUpWidget extends StatefulWidget {
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {

  final TextEditingController nomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signUp() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      if (userCredential.user != null) {
        await _firestore.collection('usuaris').doc(userCredential.user!.uid).set({
          'nom': nomController.text.trim(),
          'email': emailController.text.trim(),
          'password': passController.text.trim(),
        });

        _showSnackBar('Compte creat correctament!');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
      }
    } catch (e) {
      _showSnackBar('Error al crear el compte.');
      debugPrint('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registra\'t', style: AppStyles.appBarText), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: nomController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nom',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
              keyboardType: TextInputType.text,
            ),
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
            SizedBox(height: 20),
            ElevatedButton(onPressed: _signUp, child: Text('Crear compte')),
          ],
        ),
      ),
    );
  }
}
