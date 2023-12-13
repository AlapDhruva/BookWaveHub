import 'package:finalproject/Home.dart';
import 'package:finalproject/bookdescription.dart';
import 'package:finalproject/bookmark.dart';
import 'package:finalproject/location.dart';
import 'package:finalproject/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Set the color of the back arrow button here
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
        '/bookdetail': (context) => BookDescription(),
        '/location': (context) => Location(),
        '/bookmark': (context) => BookMark(),
      },
    );
  }
}
