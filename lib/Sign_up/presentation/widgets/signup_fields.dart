import 'package:flutter/material.dart';

class EmailSignUpField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailSignUpField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
          labelText: "Email Address",
          border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal:10,vertical: 10 )
        ),
        validator: validator,
      ),
    );
  }
}


class PasswordSignUpField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordSignUpField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal:10,vertical: 10 ),
        ),
        obscureText: true,
        validator: validator,
      ),
    );
  }
}


class ConfirmPasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;

  const ConfirmPasswordTextFormField({
    Key? key,
    required this.controller,
    required this.passwordController,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal:10,vertical: 10 ),
          border: OutlineInputBorder(),
          labelText: "Confirm Password",
        ),
        obscureText: true,
        validator: validator,
      ),
    );
  }
}

