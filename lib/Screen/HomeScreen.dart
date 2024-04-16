import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My pill'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Info button action
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3, // The count of items can be dynamically set
        itemBuilder: (BuildContext context, int index) {
          return MedicineCard();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 120, // Set your height
          color: Colors.orange, // Set your background color
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Add your icons or buttons
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicineCard extends StatefulWidget {
  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Paracetamol', style: TextStyle(fontSize: 24)),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              subtitle: Text("8:00   12:00   18:00"),
            ),
            Wrap(
              spacing: 8.0, // space between two chips
              children: <Widget>[
                Chip(label: Text('Every Sunday')),
                Chip(label: Text('Every Monday')),
                Chip(label: Text('Every Tuesday')),
                // Add more chips for other days as needed.
              ],
            ),
          ],
        ),
      ),
    );
  }
}

