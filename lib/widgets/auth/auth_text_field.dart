import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  const AuthTextField({super.key, required this.hintText, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w300
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
