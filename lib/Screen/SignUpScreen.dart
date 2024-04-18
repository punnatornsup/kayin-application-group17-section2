import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailcontroller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _password1controller = TextEditingController();
  final _password2controller = TextEditingController();
  bool _validate = false;
  bool _retypepasswordvalid = false;
  String? _errorText;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _usernamecontroller.dispose();
    _password1controller.dispose();
    _password2controller.dispose();
    super.dispose();
  }

  void _signUp() {
    setState(() {
      bool isEmailEmpty = _emailcontroller.text.isEmpty;
      bool isUsernameEmpty = _usernamecontroller.text.isEmpty;
      bool isPassword1Empty = _password1controller.text.isEmpty;
      bool isPassword2Empty = _password2controller.text.isEmpty;
      if (isEmailEmpty ||
          isPassword1Empty ||
          isUsernameEmpty ||
          isPassword2Empty) {
        // Set the state to reflect that there is a validation error
        setState(() {
          _validate = true;
          _errorText = 'Please fill in all fields';
        });
      } else if (_password1controller.text != _password2controller.text) {
        setState(() {
          _retypepasswordvalid = true;
        });
      } else {
        _validate = false;
        _retypepasswordvalid = false;
      }
    });
    if (!_validate) {
      if (!_retypepasswordvalid) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 149, 183, 255), // Replace with the exact color you want
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                  color: Color.fromARGB(255, 242, 149, 80)),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                border: OutlineInputBorder(),
                errorText: _validate ? _errorText : null,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernamecontroller,
              decoration: InputDecoration(
                labelText: 'Username',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                border: OutlineInputBorder(),
                errorText: _validate ? _errorText : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _password1controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                border: OutlineInputBorder(),
                errorText: _validate ? _errorText : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _password2controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Retype Password',labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),floatingLabelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.black),
                border: OutlineInputBorder(),
                errorText: _retypepasswordvalid ? 'Password do not match' : null,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(
                    255, 82, 121, 189), // Text Color (Foreground color)
                minimumSize: Size(double.infinity, 50), // Set the button's size
              ),
              onPressed: _signUp,
              child: Text('SIGN UP',
                  style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.white),
            )),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(
                    context); // Assuming this page was pushed onto the stack, this will go back
              },
              child: const Text(
                'Already have an account? LOGIN',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                  color: Color.fromARGB(255, 242, 149, 80),
                  decoration: TextDecoration.underline,
                )),
            ),
          ],
        ),
      ),
    );
  }
}
