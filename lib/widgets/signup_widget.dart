import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  bool _loading = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signUp() async {
    setState(() => _loading = true);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('usuaris').doc(user.uid).set({
          'nom': nomController.text.trim(),
          'email': emailController.text.trim(),
        }, SetOptions(merge: true));

        _showSnackBar('Compte creat correctament!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );
      }
    }
    on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'Aquest correu ja té un compte.\nInicia sessió amb ell.';
          break;
        case 'invalid-email':
          msg = 'El correu no és vàlid.';
          break;
        case 'weak-password':
          msg = 'La contrasenya és massa feble.';
          break;
        default:
          msg = 'Error al crear el compte: ${e.code}.';
      }
      _showSnackBar(msg);
      debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');
    }
    catch (e) {
      _showSnackBar('Error inesperat al crear el compte.');
      debugPrint('Error: $e');
    }
    finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registra\'t', style: AppStyles.appBarText),
        centerTitle: true,
      ),
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
              keyboardType: TextInputType.text,
            ),
            AppStyles.sizedBoxHeight20,
            TextFormField(
              controller: emailController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            AppStyles.sizedBoxHeight20,
            TextFormField(
              controller: passController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Contrasenya',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
              obscureText: true,
            ),
            AppStyles.sizedBoxHeight20,
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Crear compte'),
            ),
          ],
        ),
      ),
    );
  }
}