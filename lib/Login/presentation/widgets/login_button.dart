import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const LoginButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: MediaQuery.of(context).size.width * 1 / 4,

        ), // Padding inside the button
        // Minimum width and height of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
      ),

      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color:Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
