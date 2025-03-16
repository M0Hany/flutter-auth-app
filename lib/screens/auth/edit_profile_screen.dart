import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final _nameController =  TextEditingController();
  final _emailController = TextEditingController();
  final _studentIdController = TextEditingController();

  bool inEdit = false;
  User? user;
  Uint8List? _profileImage;


  @override
  void dispose() {
    // Dispose controllers to free memory
    _nameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadProfilePicture();
  }

  void _loadUserData() {
    user = _authService.getUser();
    if (user != null) {
      setState(() {
        _nameController.text = user!.name;
        _emailController.text = user!.email;
        _studentIdController.text = user!.id;
      });
    }
  }

  void _logout() {
    _authService.logout();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged out!")));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  void _loadProfilePicture() async {
    Uint8List image = await _authService.getProfilePicture();
    if (image.isNotEmpty) {
      setState(() {
        _profileImage = image;
      });
    }
  }


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _profileImage = imageBytes;
      });
      await _authService.updateProfilePicture(imageBytes);
    }
  }


  void _showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Choose from Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take a Photo"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    user = _authService.getUser();
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
                  GestureDetector(
                    onTap: _showImageSourceSelection,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(_profileImage!),
                    ),
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _nameController,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _emailController,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _studentIdController,
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AuthButton(
                          color: 0xFFFF0000,
                          onPressed: _logout,
                          label: "Logout"
                      ),
                      AuthButton(
                          onPressed: () {
                            setState(() {
                              inEdit = !inEdit;
                            });
                          },
                          label: "Edit"
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
