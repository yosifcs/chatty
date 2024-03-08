import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          labelText: 'Email Address*',
          prefixIcon: Icon(Icons.email_outlined, size: 22),
          labelStyle:
          GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          // Add additional validation logic for email address if needed
          return null;
        },
      ),
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          errorStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          labelText: 'Password*',
          prefixIcon: Icon(Icons.lock_outline, size: 22),
          labelStyle:
          GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          // Add additional validation logic for password if needed
          return null;
        },
      ),
    );
  }
}
