
import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'InformationScreen.dart';

// Assuming you have a StatefulWidget for your HomeScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Function to show the add pills popup
  void _showAddPillsPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            color: Color.fromARGB(255, 242, 149, 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height *
                0.3, // adjust the height as needed
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Add Pills',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
                SizedBox(height: 20), // For spacing
                // ... your text fields and other inputs ...
                SizedBox(
                  width: double.infinity, // To ensure it takes the full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 210, 131, 73),
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Add your pill addition logic here
                    },
                    child: Text(
                      'Add pills',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Comfortaa'),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Added spacing between the buttons
                SizedBox(
                  width: double.infinity, // To ensure it takes the full width
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 210, 131, 73),
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Comfortaa'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 149, 183, 255),
        title: Text('My pill',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
          // Your HomeScreen body here
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
              icon: Icon(Icons.add_box, size: 40), // Replace with your app icon
              onPressed: _showAddPillsPopup,
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
