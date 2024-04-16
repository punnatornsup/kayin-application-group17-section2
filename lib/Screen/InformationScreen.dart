import 'package:flutter/material.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Information', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('KAYIN', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('created by', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
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
            Container(
              width: double.infinity, // Makes the Container fill the width of the screen
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 35),
                    onPressed: () {
                      // Implement camera functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo, size: 35),
                    onPressed: () {
                      // Implement gallery functionality
                    },
                  ),
                ],
              ),
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
          radius: 60, // Increased radius for a bigger picture
          backgroundImage: AssetImage(imagePath), // Using an AssetImage, but you could use a NetworkImage for network paths
        ),
        SizedBox(height: 10),
        Text(name, style: TextStyle(fontSize: 20, color: Colors.white)),
        Text(id, style: TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
