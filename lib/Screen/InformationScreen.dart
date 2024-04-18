import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'HomeScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Comfortaa',
      ),
      home: InformationScreen(),
    );
  }
}

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      body: SingleChildScrollView( // Allows the column to be scrollable
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30), // Added some padding for layout
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Information', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
                  Text('KAYIN', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
                  Text('created by', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  ProfileWidget(name: 'Panodpong Yanyongweroj', id: '6587056', imagePath: 'images/6587056_photo.jpg'),
                  ProfileWidget(name: 'Punnatorn Supinyo', id: '6587022', imagePath: 'images/6587022_photo.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 242, 149, 80),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 40),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String name;
  final String id;
  final String imagePath;

  const ProfileWidget({
    Key? key,
    required this.name,
    required this.id,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 57,
          backgroundImage: AssetImage(imagePath),
          // Adding a BoxFit property to ensure the image covers the avatar area
          child: ClipOval(
            child: Image.asset(
              imagePath,
               // This scales the image uniformly until it fills the avatar space
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
        Text(id, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
      ],
    );
  }
  
}