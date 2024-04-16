import 'package:flutter/material.dart';
import "./Screen/LoadingScreen.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

