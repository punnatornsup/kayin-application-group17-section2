import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginScreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                    color: Color.fromARGB(255, 242, 149, 80))),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black) ,hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                  hintText: 'Enter valid email',
                  errorText: _validate ? "Please enter you Email" : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                controller: _passwordcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                  hintText: 'Enter your secure password',
                  errorText: _validate ? "Please enter you Email" : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 108, 147, 16),
                  borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(
                      255, 82, 121, 189), // Text Color (Foreground color)
                  minimumSize:
                      Size(double.infinity, 50), // Set the button's size
                ),
                onPressed: () {
                  bool isEmailEmpty = _emailcontroller.text.isEmpty;
                  bool isPasswordEmpty = _passwordcontroller.text.isEmpty;
                  if (isEmailEmpty || isPasswordEmpty) {
                    // Set the state to reflect that there is a validation error
                    setState(() {
                      _validate = true;
                    });
                  } else {
                    // If both fields are filled, navigate to the HomeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
                child: Text('Login',
                    style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.white),
              )),
            ),
            GestureDetector(
              onTap: () {
                // When the user taps this text, navigate to the SignUpScreen.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                'Don\'t have an account? SIGN UP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                  color: Color.fromARGB(255, 242, 149, 80),
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
