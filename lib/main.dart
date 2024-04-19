import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "./Screen/LoadingScreen.dart";
import "Screen/testDatabase.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp((MyApp()));
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 149, 183, 255),
      ),
      // home: MyWidget(),
      home: LoadingScreen(),
    );
  }
}

