import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class kayinuser {
  String email;
  String name;
  String password;

  kayinuser({
    required this.email,
    required this.name,
    required this.password,
  });
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}



class _LoginDemoState extends State<LoginScreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Future<bool> authenUsernamepassword(String userinput,String userpassword) async {
    try {
      var userQuery = await FirebaseFirestore.instance
          .collection('Kayin_User')
          .where('Email', isEqualTo: userinput)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Assuming 'Email', 'Username', and 'password' are the field names in Firestore
        var userData = userQuery.docs.first.data();
        print(userData);

        if(userData['password'] == userpassword){
          return true;
        }
      }

      return false;
    } catch (e) {
      print('Error fetching user: $e');

      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login',
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
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  floatingLabelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  hintStyle: const TextStyle(
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
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  floatingLabelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                      color: Colors.black),
                  hintStyle: const TextStyle(
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
                  onPressed: () async {
                    // Validate that the email and password are not empty
                    bool isEmailEmpty = _emailcontroller.text.isEmpty;
                    bool isPasswordEmpty = _passwordcontroller.text.isEmpty;
                    if (isEmailEmpty || isPasswordEmpty) {
                      setState(() {
                        _validate = true; // Show validation errors
                      });
                    } else {
                      setState(() {
                        _validate = false; // Clear validation errors
                      });

                      // print(_emailcontroller.text);
                      // Attempt to log in the user
                      bool loginSuccessful = await authenUsernamepassword(
                          _emailcontroller.text, _passwordcontroller.text);
                      if (loginSuccessful) {
                        // If login is successful, navigate to the HomeScreen
                       
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(useremail:_emailcontroller.text ,)),
                          );
                        } else {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Login Failed"),
                              content: new Text(
                                  "Please check your email and password and try again."),
                              actions: <Widget>[
                                TextButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        }
                    
                    }
                  },
                  child: const Text(
                    'Login',
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
              child: const Text(
                'Don\'t have an account? SIGN UP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                  color: Color.fromARGB(255, 242, 149, 80),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
