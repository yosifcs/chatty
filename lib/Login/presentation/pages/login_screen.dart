import 'package:chatt/Home/presentation/pages/home_screen.dart';
import 'package:chatt/Login/presentation/widgets/forgot_password_textbutton.dart';
import 'package:chatt/Login/presentation/widgets/login_button.dart';
import 'package:chatt/Login/presentation/widgets/login_fields.dart';
import 'package:chatt/Login/presentation/widgets/signup_textbutton.dart';
import 'package:chatt/Sign_up/presentation/pages/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggedIn = false;
  Future<void> login(BuildContext context) async {
    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        isLoggedIn = true;
      });
      await Future.delayed(Duration(seconds: 1));
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    } catch (e) {
      print("Login Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login failed. Please check your credentials.",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height / 5),
              Icon(
                isLoggedIn ? Icons.lock_open : Icons.lock_outline, // Change the icon based on login state
                size: 100,
                color: isLoggedIn ? Colors.green : null, // Change color if needed
              ),
              Text(
                'Welcome',
                style: GoogleFonts.poppins(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              EmailTextFormField(
                controller: emailController,
              ),
              PasswordTextFormField(
                controller: passwordController,
              ),
              LoginButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login(context);
                    }
                  },
                  text: "Sign in"),
              ForgotPasswordButton(),
              SignUpTextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_screen(),));
              },),
            ],
          ),
        ),
      ),
    );
  }
}
