import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType keyboardType;

  const AuthTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFF252EFF), width: 2.0)
        ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFFed4337), width: 2.0)
        ),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
            borderSide: const BorderSide(color: Color(0xFFed4337), width: 2.0)
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
