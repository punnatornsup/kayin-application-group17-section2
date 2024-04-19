import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  MyWidget({super.key});
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: firebase, builder: (context, snapshot){
      // if (snapshot.hasError){
      //   return Placeholder();
      // }
      return Placeholder();
    }
    );
  }
}