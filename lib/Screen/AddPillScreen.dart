import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPillScreen extends StatefulWidget {
  final String useremail;
  AddPillScreen({required this.useremail});
  @override
  _AddPillScreenState createState() => _AddPillScreenState();
}

class _AddPillScreenState extends State<AddPillScreen> {
  String pillName = '';
  TimeOfDay? pillTime;
  List<String> days = []; // Store the selected days here
  final List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  Map<String, bool> dayToggles = {};

  @override
  void initState() {
    super.initState();
    // Initialize toggle state for each day
    allDays.forEach((day) {
      dayToggles[day] = false;
    });
  }

  Future<void> _savePill() async {
    // Get the current user
    String useremail = widget.useremail;
    var userQuery = await FirebaseFirestore.instance
        .collection('Kayin_User')
        .where('Email', isEqualTo: useremail)
        .get();

    print(userQuery.docs[0].id);
    if (pillName.isNotEmpty && pillTime != null && days.isNotEmpty) {
      String userId = userQuery.docs[0].id; // The user's unique ID
      final pillData = {
        'name': pillName,
        'time': '${pillTime!.hour}:${pillTime!.minute}',
        'days': days.where((day) => dayToggles[day] == true).toList(),
      };

      FirebaseFirestore.instance
          .collection(
              'Kayin_User') // Assuming 'Kayin_User' is your user collection
          .doc(userId) // The user's document ID
          .collection('pills') // The subcollection for pills
          .add(pillData)
          .then((docRef) {
        print('Pill added with ID: ${docRef.id}');
        Navigator.pop(
            context, pillData); // Pass the pill data back to the HomeScreen
      }).catchError((error) {
        print('Error adding pill: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding pill: $error')),
        );
      });
    } else {
      // Show an error or prompt to fill all the fields
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void _selectTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null && time != pillTime) {
      setState(() {
        pillTime = time;
      });
    }
  }

  void _onDayToggled(String day, bool isSelected) {
    setState(() {
      dayToggles[day] = isSelected;
      if (isSelected) {
        days.add(day);
      } else {
        days.remove(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 149, 183, 255), // Set background color
      appBar: AppBar(
        title: Text(
          'Add Pill',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comfortaa',
            color: Colors.white, // Set text color for AppBar
          ),
        ),
        backgroundColor: Color.fromARGB(255, 149, 183, 255),
        elevation: 0, // Removes shadow under the AppBar
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow when keyboard appears
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .center, // Center the column contents vertically
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Stretch the elements to fit the screen width
            children: [
              TextField(
                onChanged: (value) => pillName = value,
                decoration: InputDecoration(
                  labelText: 'Pill Name',
                  labelStyle: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Colors.white, // Set text color for label
                  ),
                  enabledBorder: OutlineInputBorder(
                    // Border color when TextField is not focused
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Border color when TextField is focused
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Colors.white, // Set text color for input text
                ),
                cursorColor: Colors.white, // Set cursor color
              ),
              SizedBox(height: 20), // Add space between elements
              ElevatedButton(
                onPressed: _selectTime,
                child: Text(
                  pillTime?.format(context) ?? 'Select Time',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Colors.white, // Set text color for button text
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .blue[700], // Use a shade of blue from the color palette
                ),
              ),
              SizedBox(height: 20), // Add space between elements
              Wrap(
                spacing: 8.0, // Add some spacing between the chips
                runSpacing: 8.0, // Add some spacing between the lines of chips
                alignment: WrapAlignment.center, // Center the chips
                children: allDays
                    .map((day) => ChoiceChip(
                          label: Text(
                            day,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              color: dayToggles[day]!
                                  ? Colors.white
                                  : Colors
                                      .black, // Toggle text color based on selection
                            ),
                          ),
                          selected: dayToggles[day]!,
                          selectedColor: Colors.blue[
                              700], // Use a shade of blue for selected chips
                          onSelected: (isSelected) =>
                              _onDayToggled(day, isSelected),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20), // Add space between elements
              ElevatedButton(
                onPressed: _savePill,
                child: Text(
                  'Save Pill',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Comfortaa',
                    color: Colors.white, // Set text color for button text
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Set the button color to green
                  padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20), // Add padding to the button
                  shape: RoundedRectangleBorder(
                    // Round the button corners
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
