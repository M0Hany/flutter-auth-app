import 'package:flutter/material.dart';
import 'package:login/core/utils/validators.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_title.dart';
import 'edit_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String studentId = "";
  String password = "";

  final AuthService _authService = AuthService();

  void _login() async {
    final url = Uri.parse('http://10.0.2.2:3000/login'); // Node.js login endpoint

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'studentID': studentId,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        _authService.loginUser(studentId, password);
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => EditProfileScreen()),
        );
      } else {
        // Login failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } catch (e) {
      // Handle connection errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to connect to the server')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _login();
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

