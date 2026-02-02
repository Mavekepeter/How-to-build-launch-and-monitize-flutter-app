import 'package:chattera/features/auth/presentation/pages/login_page.dart';
import 'package:chattera/firebase_options.dart';
import 'package:chattera/themes/dark_mode.dart';
import 'package:chattera/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: darkMode,
    );
  }
}
