import 'package:flutter/material.dart';
import 'LoginScreen.dart'; // This is the screen you navigate to from LoadingScreen

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Redirect to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/Logo-removebg.png',fit: BoxFit.fill,height: 500,
  width: 500,),
            Text('KAYIN', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
