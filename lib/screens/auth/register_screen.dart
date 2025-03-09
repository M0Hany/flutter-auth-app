import 'package:flutter/material.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_radio.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedGender = "Male"; // Default gender selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              AuthTitle(title: "Register"),
              SizedBox(height: 30),
              AuthTextField(hintText: "Full Name"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Email"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Student ID"),
              SizedBox(height: 18),
              AuthTextField(hintText: "Password", isPassword: true),
              SizedBox(height: 18),
              AuthTextField(hintText: "Confirm Password", isPassword: true),
              SizedBox(height: 30),

              /// Gender Selection
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Gender:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  AuthRadio(
                      title: "Male",
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      }),
                  AuthRadio(
                      title: "Female",
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      }),
                ],
              ),

              SizedBox(height: 40),
              AuthButton(
                label: "Register",
                onPressed: () {},
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
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