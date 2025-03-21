import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:login/models/user_model.dart';
import 'package:login/screens/auth/change_password_screen.dart';
import 'package:login/screens/auth/edit_profile_screen.dart';
import 'package:login/screens/auth/login_screen.dart';
import 'package:login/screens/auth/register_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());


  await Hive.openBox<User>('users');
  await Hive.openBox('auth');
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set the default route
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/edit_profile': (context) => EditProfileScreen(),
        '/change_password': (context) => ChangePasswordScreen(),
      },
    );
  }
}