import 'package:flutter/material.dart';
import 'AddPillScreen.dart';
import 'ProfileScreen.dart';
import 'InformationScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> pills = [];

  void _showAddPillsPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
              color: Color.fromARGB(255, 242, 149, 80),
              width: double.infinity,
              height: 250, // adjust the height as needed
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Add Pills',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Comfortaa',
                          color: Colors.white)),
                  SizedBox(height: 20), // For spacing
                  // ... your text fields and other inputs ...
                  SizedBox(
                    width: double.infinity, // To ensure it takes the full width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 210, 131, 73),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context); // Close the modal first
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPillScreen()),
                        );
                        if (result != null) {
                          setState(() {
                            pills.add(result as Map<String, dynamic>);
                          });
                        }
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      body: ListView.builder(
        itemCount: pills.length,
        itemBuilder: (context, index) {
          final pill = pills[index];
          return ListTile(
            title: Text(pill['name']),
            subtitle: Text('${pill['time']} - ${pill['days'].join(", ")}'),
          );
        },
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
              onPressed: _showAddPillsPopup,
              icon: SizedBox(
                width: 80, // Set your width
                height:
                    80, // Set your height, keep it the same as width for a square aspect ratio
                child: Image.asset('images/Logo-removebg.png'),
              ),
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
