import 'package:flutter/material.dart';
import "./Screen/LoadingScreen.dart";
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 149, 183, 255),
      ),
      home: LoadingScreen(),
    );
  }
}

