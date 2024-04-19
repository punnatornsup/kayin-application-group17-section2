import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'InformationScreen.dart';
import 'AddPillScreen.dart';

// Assuming you have a StatefulWidget for your HomeScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map> pillsData = [];

  @override
  void didChangeDependencies() {
  super.didChangeDependencies();
  // Fetch the pills data when the screen's dependencies change, i.e., when it's navigated back to
  // This could fetch from a Provider, database, etc., depending on your state management
}
  // Function to show the add pills popup
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
              height: 250,// adjust the height as needed
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
                        padding: EdgeInsets.symmetric(
                            vertical: 15), // Vertical padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPillScreen()),
                );
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
      backgroundColor: Color.fromARGB(255, 149, 183, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 149, 183, 255),
        title: Text('My pill',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
                color: Colors.white)),
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
      itemCount: pillsData.length,
      itemBuilder: (context, index) {
        final pill = pillsData[index];
        return ListTile(
          title: Text(pill['name']),
          subtitle: Text('${pill['time']} on ${pill['days'].join(", ")}'),
          // ... additional pill info
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
