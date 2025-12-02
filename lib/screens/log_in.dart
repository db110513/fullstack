import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/login_widget.dart';
import '../widgets/to_signup.dart';
import '../utils/text_field_validator.dart';
import '../styles/app_styles.dart';
import 'menu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool codeSent = false;
  String verificationId = '';

  Future<void> sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text.trim(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sessió iniciada automàticament')),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de verificació: ${e.message}')),
        );
      },
      codeSent: (String verId, int? forceResendToken) {
        setState(() {
          codeSent = true;
          verificationId = verId;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> verifyOTP() async {
    String otp = otpController.text.trim();
    if (verificationId.isNotEmpty && otp.isNotEmpty) {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);

      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sessió iniciada correctament')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error durant la verificació: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginWidget();
  }

}
