import 'package:chatt/Login/presentation/pages/login_screen.dart';
import 'package:chatt/Sign_up/presentation/widgets/signUp_button.dart';
import 'package:chatt/Sign_up/presentation/widgets/signup_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup_screen extends StatelessWidget {
  Signup_screen({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      FirebaseFirestore _fireStore = FirebaseFirestore.instance;
      if (isPwdConfirmed()) {
        var authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        String userId = authResult.user!.uid;


        await _fireStore.collection("users").doc(userId).set({
          'userId': userId,
          'email': emailController.text.trim(),
          // Add more user information if needed
        },SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Signed up successfully!',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: 'password-mismatch',
          message: 'Passwords do not match',
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email';
      } else if (e.code == 'password-mismatch') {
        errorMessage = e.message ?? 'Passwords do not match';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  bool isPwdConfirmed() {
    return confirmpasswordController.text.trim() ==
        passwordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Sign up your Email",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          "Let's Create an account for you",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 50,
                    thickness: 2,
                  ),
                  EmailSignUpField(controller: emailController),
                  const SizedBox(height: 16),
                  PasswordSignUpField(controller: passwordController),
                  const SizedBox(height: 16),
                  ConfirmPasswordTextFormField(
                      controller: confirmpasswordController,
                      passwordController: passwordController),
                  const SizedBox(height: 16),
                  SignUpButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp(context);
                    }
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Text("Or"),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Sign up With",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue.shade700),
                            child: Icon(
                              Icons.facebook_outlined,
                              color: Colors.white,
                              size: 50,
                            )),
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                            child: Icon(
                              Icons.g_mobiledata,
                              color: Colors.white,
                              size: 50,
                            )),
                      ),
                    ],
                  )

                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
