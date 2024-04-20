import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'HomeScreen.dart';



class InformationScreen extends StatefulWidget {

  final String useremail;
  InformationScreen({required this.useremail});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Comfortaa',
      ),
      home: Scaffold(
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
              icon: Icon(Icons.home, size: 40,color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(useremail: widget.useremail,)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 40,color: Colors.white,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(useremail: widget.useremail,)),
                );
              },
            ),
          ],
        ),
      ),
    )
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
        CircleAvatar(backgroundColor: Color.fromARGB(255, 149, 183, 255),
          radius: 60,
          // Adding a BoxFit property to ensure the image covers the avatar area
          child: ClipRRect(
            borderRadius:BorderRadius.circular(50),
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