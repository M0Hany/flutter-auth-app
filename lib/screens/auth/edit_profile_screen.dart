import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:login/models/user_model.dart';
import 'package:login/services/auth_service.dart';
import 'package:login/widgets/auth/auth_button.dart';
import 'package:login/widgets/auth/auth_dropdown.dart';
import 'package:login/widgets/auth/auth_radio.dart';
import 'package:login/widgets/auth/auth_text_field.dart';
import 'package:login/widgets/auth/auth_title.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String  _selectedGender = '';
  String  _selectedLevel = '';


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
        _selectedGender = user!.gender;
        _selectedLevel = user!.level;
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
      _updateProfile();
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

  void _updateProfile() async {
    final url = Uri.parse('http://10.0.2.2:3000/update-student'); // Use localhost IP for Android emulator

    final request = http.MultipartRequest('PUT', url)
      ..fields['studentID'] = _studentIdController.text
      ..fields['name'] = _nameController.text
      ..fields['email'] = _emailController.text
      ..fields['gender'] = _selectedGender
      .. fields['level'] = _selectedLevel;

    _authService.updateProfileDetails(
      name: _nameController.text,
      email: _emailController.text,
      id:  _studentIdController.text,
      level: _selectedLevel,
      gender: _selectedGender
    );

    if (_profileImage != null) {
      final profilePic = http.MultipartFile.fromBytes(
        'image',
        _profileImage!,
        filename: 'profile_picture.jpg',
      );
      request.files.add(profilePic);
    }

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
                    isEnabled: false,
                    controller: _studentIdController,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: false,
                    controller: _emailController,
                  ),
                  SizedBox(height: 18),
                  AuthTextField(
                    isEnabled: inEdit,
                    controller: _nameController,
                  ),
                  SizedBox(height: 18),
                  AuthDropdown(
                    onChanged: inEdit ? (newValue) {
                      setState(() {
                        _selectedLevel = newValue!;
                      });
                    } : null,
                    items: ["1", "2", "3", "4"],
                    hintText: "Select Your Level",
                    label: "Level",
                    isEnabled: inEdit,
                    value: _selectedLevel.isEmpty ? null : _selectedLevel,
                  ),
                  SizedBox(height: 18),
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
                        onChanged: inEdit ? (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        } : null,
                      ),
                      AuthRadio(
                        title: "Female",
                        value: "Female",
                        groupValue: _selectedGender,
                        onChanged: inEdit ? (newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        } : null,
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Visibility(
                    visible: !inEdit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  ),
                  Visibility(
                    visible: inEdit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AuthButton(
                            color: 0xFFFF0000,
                            onPressed: (){
                              setState(() {
                                inEdit = !inEdit;
                              });
                              _loadUserData();
                            },
                            label: "Cancel"
                        ),
                        AuthButton(
                            onPressed: _updateProfile,
                            label: "Confirm"
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: AuthButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/change_password");
                        },
                        label: "Change Password",
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
