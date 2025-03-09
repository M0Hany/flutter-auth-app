import 'package:flutter/material.dart';
import 'package:login/core/utils/validators.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String studentId = "";
  String password = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Logging in with: $studentId, $password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                AuthTitle(title: "Login"),
                SizedBox(height: 30),
                AuthTextField(
                    hintText: "Student ID",
                    onSaved: (value) => studentId = value!,
                    validator: (value) => Validators.validateRequired(value, "Student ID"),
                ),
                SizedBox(height: 18),
                AuthTextField(
                    hintText: "Password",
                    isPassword: true,
                    onSaved: (value) => password = value!,
                    validator: (value) => Validators.validateRequired(value, "Password"),
                ),
                SizedBox(height: 40),
                AuthButton(
                  label: "Login",
                  onPressed: _submitForm,
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: Text("Don't have an account? Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

