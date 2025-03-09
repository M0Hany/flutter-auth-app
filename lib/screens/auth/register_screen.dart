import 'package:flutter/material.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              AuthTitle(title: "Register"),
              SizedBox(height: 30),
              AuthTextField(hintText: "Full Name"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Email"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Username"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Password", isPassword: true),
              SizedBox(height: 18),
              AuthTextField(hintText: "Confirm Password", isPassword: true),
              SizedBox(height: 40),
              AuthButton(label: "Register", onPressed: () {}),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
