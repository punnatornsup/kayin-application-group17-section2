import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage('assets/profile_picture.png'), // replace with your asset image
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
              'Panodpong Yanyongweroj',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          InfoCard('20 years', 'Age'),
          InfoCard('55 kg', 'Weight'),
          InfoCard('180 cm', 'Height'),
          InfoCard('B', 'Blood type'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: ElevatedButton(
              child: Text('Edit'),
              onPressed: () {
                // Implement your edit functionality here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget InfoCard(String info, String label) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ListTile(
        title: Text(label),
        subtitle: Text(info),
      ),
    );
  }
}
