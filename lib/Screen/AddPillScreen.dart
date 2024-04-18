import 'package:flutter/material.dart';

class AddPillScreen extends StatefulWidget {
  @override
  _AddPillScreenState createState() => _AddPillScreenState();
}

class _AddPillScreenState extends State<AddPillScreen> {
  String pillName = '';
  TimeOfDay? pillTime;
  List<String> days = []; // Store the selected days here

  void _savePill() {
    if (pillName.isNotEmpty && pillTime != null && days.isNotEmpty) {
      // Save the pill
      final pillData = {
        'name': pillName,
        'time': pillTime,
        'days': days,
      };
      // Use a provider, bloc, or any state management to save this data
      // Then pop the screen
      Navigator.pop(context, pillData); // Pass the pill data back to the HomeScreen
    } else {
      // Show an error or prompt to fill all the fields
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Pill')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => pillName = value,
            decoration: InputDecoration(labelText: 'Pill Name'),
          ),
          ElevatedButton(
            onPressed: _selectTime,
            child: Text(pillTime?.format(context) ?? 'Select Time'),
          ),
          // Add toggle buttons or checkboxes for selecting days
          // ...
          ElevatedButton(
            onPressed: _savePill,
            child: Text('Save Pill'),
          ),
        ],
      ),
    );
  }
}
