import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import '../models/user_model.dart';

class AuthService {
  final Box<User> userBox = Hive.box<User>('users');
  final Box authBox = Hive.box('auth'); // Store session data

  // Register User
  Future<String> registerUser(String name, String? gender, String email, String id, String? level, String password) async {
    if (userBox.containsKey(id)) {
      return "ID already exists!";
    }
    userBox.put(id, User(name: name,  gender: gender ?? '', email: email, id: id, level: level ?? '', password: password));
    return "User registered successfully!";
  }

  Future<void> saveUserLocally(User user) async {
    await userBox.put(user.id, user); // Saving user to Hive with their username as key
  }

  // Login User
  Future<String> loginUser(String id, String password) async {
    final user = userBox.get(id);
    if (user == null || user.password != password) {
      return "Invalid username or password!";
    }
    authBox.put('loggedInUser', id); // Store session
    return "Login successful!";
  }


  // Check if user is logged in
  bool isUserLoggedIn() {
    return authBox.containsKey('loggedInUser');
  }

  // Logout
  void logout() {
    authBox.delete('loggedInUser');
  }

  String? getLoggedInUsername() {
    return authBox.get('loggedInUser');
  }

  User? getUser(){
    String? username = getLoggedInUsername();
    if (username != null) {
      return userBox.get(username);
    }
    return null;
  }

  Future<void> updateProfilePicture(Uint8List imageBytes) async {
    String? username = getLoggedInUsername();
    if (username != null) {
      User? user = userBox.get(username);
      if (user != null) {
        user = User(
          id: user.id,
          password: user.password,
          email: user.email,
          level: user.level,
          gender: user.gender,
          name: user.name,
          profilePicture: imageBytes, // Save new image
        );
        await userBox.put(username, user);
      }
    }
  }

  Future<Uint8List> getProfilePicture() async {
    String? username = getLoggedInUsername();
    if (username != null) {
      User? user = userBox.get(username);
      if (user?.profilePicture != null) {
        return user!.profilePicture!;
      }
    }

    ByteData bytes = await rootBundle.load("assets/images/default.jpg");
    return bytes.buffer.asUint8List();
  }

  Future<void> updateProfileDetails(
      {String? name, String? gender, String? email, String? password, String? id, String? level}) async {
    String? username = getLoggedInUsername();
    if (username != null) {
      User? user = userBox.get(username);
      if (user != null) {
        user = User(
          id: user.id,
          password: password ?? user.password,
          email: email ?? user.email,
          level: level ?? user.level,
          gender: gender ?? user.gender,
          name: name ?? user.name,
          profilePicture: user.profilePicture, // Save new image
        );
        await userBox.put(username, user);
      }
    }
  }

  Future<bool> validateOldPassword(String oldPassword) async {
    User? loggedInUser = getUser();
    if (loggedInUser == null) {
      return false;  // No user logged in
    }
    return loggedInUser.password == oldPassword;
  }

  Future<void> updateUserPassword(String newPassword) async {
    User? loggedInUser = getUser();
    if (loggedInUser != null) {
      loggedInUser.password = newPassword;
      final box = await Hive.openBox('userBox');
      await box.put(loggedInUser.id, loggedInUser);
    }
  }
}
