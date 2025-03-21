import 'package:flutter/material.dart';
import 'package:login/core/utils/validators.dart';
import 'package:login/models/user_model.dart';
import 'package:login/screens/auth/edit_profile_screen.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}


class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassowrdController = TextEditingController();
  final _newPassowrdController = TextEditingController();
  final _confirmPassowrdController = TextEditingController();
  final AuthService _authService = AuthService();
  User? user;

  @override
  void dispose() {
    // Dispose controllers to free memory
    _oldPassowrdController.dispose();
    _newPassowrdController.dispose();
    _confirmPassowrdController.dispose();
    super.dispose();
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      bool isOldPasswordValid = await _authService.validateOldPassword(_oldPassowrdController.text);

      if (!isOldPasswordValid) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Old password is incorrect')));
        return;
      }


      final url = Uri.parse('http://10.0.2.2:3000/update-student'); // Use localhost IP for Android emulator

      final request = http.MultipartRequest('PUT', url)
        ..fields['studentID'] = _authService.getLoggedInUsername()!
        ..fields['password'] = _newPassowrdController.text;

      _authService.updateProfileDetails(password: _newPassowrdController.text);

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          final responseData = await response.stream.bytesToString();
          final decodedResponse = json.decode(responseData);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'])));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => EditProfileScreen()),
          );
        } else {
          final responseData = await response.stream.bytesToString();
          final decodedResponse = json.decode(responseData);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'])));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 150),
                AuthTitle(title: "Change Password"),
                SizedBox(height: 30),
                AuthTextField(
                  isPassword: true,
                  hintText: "Enter Your Current Password",
                  controller: _oldPassowrdController,
                  validator: (value) => Validators.validateRequired(value, "Current Password"),
                ),
                SizedBox(height: 18),
                AuthTextField(
                  isPassword: true,
                  hintText: "Enter Your New Password",
                  controller: _newPassowrdController,
                  validator: (value) => Validators.validatePassword(value),
                ),
                SizedBox(height: 18),
                AuthTextField(
                  isPassword: true,
                  hintText: "Confirm Your New Password",
                  controller: _confirmPassowrdController,
                  validator: (value) => Validators.validateConfirmPassword(value, _newPassowrdController.text),
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AuthButton(
                        onPressed: () {
                          Navigator.pop(context); // Use this to pop the screen when the button is pressed
                        },
                        label: "Cancel",
                        color: 0xFFFF0000,
                    ),
                    AuthButton(
                        onPressed: _submitForm,
                        label: "Confirm"
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
