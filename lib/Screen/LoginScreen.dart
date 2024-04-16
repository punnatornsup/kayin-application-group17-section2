import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
                  labelText: 'Email',
                  hintText: 'Enter valid email',
                  errorText: _validate ? "Please enter your Email." : null,
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
                  hintText: 'Enter your secure password',
                  errorText: _validate ? "Please enter your Password." : null,
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
                  setState(() {
                    _validate = _emailcontroller.text.isEmpty || _passwordcontroller.text.isEmpty;
                  });
                  if (!_validate) {
                    AuthService authService = AuthService();
                    authService.signInWithEmailAndPassword(_emailcontroller.text, _passwordcontroller.text).then((user) {
                      if (user != null) {
                        print('Login successful!');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      } else {
                        print('Login failed');
                      }
                    });
                  }
                },
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 25)),
              ),
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
                  color: Colors.orange,
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

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
