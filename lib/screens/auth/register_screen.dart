import 'package:flutter/material.dart';
import 'package:login/core/utils/validators.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_dropdown.dart';
import 'package:login/widgets/auth/auth_radio.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedGender = "";
  String _selectedLevel = "";

  @override
  void dispose() {
    // Dispose controllers to free memory
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, retrieve values
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String studentId = _studentIdController.text.trim();
      String password = _passwordController.text;

      print(
        "Registering User: $name, $email, $studentId, Gender: $_selectedGender, Level: $_selectedLevel",
      );

      // TODO: Implement actual registration logic (e.g., send data to backend)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                AuthTitle(title: "Register"),
                SizedBox(height: 30),
                AuthTextField(
                  hintText: "Full Name*",
                  controller: _nameController,
                  validator:
                      (value) =>
                          Validators.validateRequired(value, "Full name"),
                ),
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
                      },
                    ),
                    AuthRadio(
                      title: "Female",
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 18),
                AuthTextField(
                  hintText: "Email*",
                  controller: _emailController,
                  validator: (value) => Validators.validateEmail(value),
                ),
                SizedBox(height: 18),
                AuthTextField(
                  hintText: "Student ID*",
                  controller: _studentIdController,
                  validator:
                      (value) => Validators.validateStudentID(
                        value,
                        _emailController.text,
                      ),
                ),
                SizedBox(height: 18),
                AuthDropdown(
                  items: ["1", "2", "3", "4"],
                  hintText: "Select Your Level",
                  label: "Level",
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLevel = newValue;
                    });
                  },
                ),
                SizedBox(height: 18),
                AuthTextField(
                  hintText: "Password*",
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) => Validators.validatePassword(value),
                ),
                SizedBox(height: 18),
                AuthTextField(
                  hintText: "Confirm Password*",
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator:
                      (value) => Validators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                ),
                SizedBox(height: 40),
                AuthButton(label: "Register", onPressed: _submitForm),
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
      ),
    );
  }
}
