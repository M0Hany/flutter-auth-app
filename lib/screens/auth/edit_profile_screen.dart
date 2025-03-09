import 'package:flutter/material.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =  TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free memory
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  bool inEdit = false;
  final Map<String, String> data = {
    "name" : "Mohamed Hany",
    "email" : "20210358@stud.fci-cu.edu.eg",
    "id" : "20210358",
  };

  @override
  void initState() {
    super.initState();

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
                  AuthTitle(title: "Edit Profile"),
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 50,
                    foregroundImage: AssetImage("assets/images/default.jpg"),
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _nameController..text = data["name"]!,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _emailController..text = data["email"]!,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _studentIdController..text = data["id"]!,
                  ),
                  SizedBox(height: 18),
                  AuthButton(
                      onPressed: () {
                        setState(() {
                          inEdit = !inEdit;
                        });
                      },
                      label: "Edit"
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
