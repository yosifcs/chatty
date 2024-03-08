import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          // Add functionality for the forgot password button here
        },
        child: Text(
          "Forgot your password?",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color:Colors.grey.shade700),
        ),
      ),
    );
  }
}
