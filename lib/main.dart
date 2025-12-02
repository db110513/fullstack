import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reus Deportiu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            elevation: 2,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white24,
          selectionHandleColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ca'),
        Locale('es'),
      ],
      home: const Home(),
    );
  }
}