// import 'package:flutter/material.dart';

// class AddPillScreen extends StatefulWidget {
//   @override
//   _AddPillScreenState createState() => _AddPillScreenState();
// }

// class _AddPillScreenState extends State<AddPillScreen> {
//   String pillName = '';
//   TimeOfDay? pillTime;
//   List<String> days = []; // Store the selected days here

//   void _savePill() {
//     if (pillName.isNotEmpty && pillTime != null && days.isNotEmpty) {
//       // Save the pill
//       final pillData = {
//         'name': pillName,
//         'time': pillTime,
//         'days': days,
//       };
//       // Use a provider, bloc, or any state management to save this data
//       // Then pop the screen
//       Navigator.pop(context, pillData); // Pass the pill data back to the HomeScreen
//     } else {
//       // Show an error or prompt to fill all the fields
//     }
//   }

//   void _selectTime() async {
//     final TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time != null && time != pillTime) {
//       setState(() {
//         pillTime = time;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Pill')),
//       body: Column(
//         children: [
//           TextField(
//             onChanged: (value) => pillName = value,
//             decoration: InputDecoration(labelText: 'Pill Name'),
//           ),
//           ElevatedButton(
//             onPressed: _selectTime,
//             child: Text(pillTime?.format(context) ?? 'Select Time'),
//           ),
//           // Add toggle buttons or checkboxes for selecting days
//           // ...
//           ElevatedButton(
//             onPressed: _savePill,
//             child: Text('Save Pill'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPillScreen extends StatefulWidget {
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

  void _savePill() {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    if (user != null &&
        pillName.isNotEmpty &&
        pillTime != null &&
        days.isNotEmpty) {
      String userId = user.uid; // The user's unique ID
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
          Wrap(
            children: allDays
                .map((day) => ChoiceChip(
                      label: Text(day),
                      selected: dayToggles[day]!,
                      onSelected: (isSelected) =>
                          _onDayToggled(day, isSelected),
                    ))
                .toList(),
          ),
          ElevatedButton(
            onPressed: _savePill,
            child: Text('Save Pill'),
          ),
        ],
      ),
    );
  }
}
