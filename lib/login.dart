import 'package:finalproject/services/FirebaseAuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[400],
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BookWaveHub",
                style: GoogleFonts.akayaTelivigala(
                  textStyle: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'serif'),
              ),
              SizedBox(height: 16.0),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  labelText: 'Email',
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: _signIn,
                child: Text('Login'),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Not a member? Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("User is successfully SignIn");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Welcome, " + "${user.email}")));
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Incorrect Username or Password!")));
    }
  }
}
