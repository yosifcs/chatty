import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpTextButton extends StatelessWidget {
  final VoidCallback onPressed;

  SignUpTextButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Sign up",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}
