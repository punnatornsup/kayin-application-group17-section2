import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Add this import to use File

// Assuming UserProfile is defined in a separate file and imported here.
// If not, you'll need to include the UserProfile class definition here as well.

class EditProfileScreen extends StatefulWidget {
  final UserProfile user;

  EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _medicalConditionController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _bloodTypeController;
  // Add more controllers for each field

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _ageController = TextEditingController(text: widget.user.age);
    _medicalConditionController =
        TextEditingController(text: widget.user.medicalCondition);
    _weightController = TextEditingController(text: widget.user.weight);
    _heightController = TextEditingController(text: widget.user.height);
    _bloodTypeController = TextEditingController(text: widget.user.bloodType);
    // Initialize more controllers for each field
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _medicalConditionController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _bloodTypeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Let the user select an image from the gallery or take a new one with the camera
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        // Here we're creating a FileImage with the selected image file
        widget.user.profileImage = FileImage(File(image.path));
      });
    }
  }

  void _saveProfile() {
    // Implement saving logic here
    // For example, set the new values in the userProfile object
    setState(() {
      widget.user.name = _nameController.text;
      widget.user.age = _ageController.text;
      widget.user.medicalCondition = _medicalConditionController.text;
      widget.user.weight = _weightController.text;
      widget.user.height = _heightController.text;
      widget.user.bloodType = _bloodTypeController.text;
      // Update the user profile with the values from the controllers
    });

    // Pop the screen and return the updated user profile
    Navigator.pop(context, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 85,
              backgroundImage: widget.user.profileImage,
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.camera_alt, color: Colors.grey[700]),
                ),
              ),
            ),
          ),
          SizedBox(
              height:
                  24), // Give some space between the image and the text fields
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          TextField(
            controller: _medicalConditionController,
            decoration: InputDecoration(labelText: 'Medical Condition'),
          ),
          TextField(
            controller: _weightController,
            decoration: InputDecoration(labelText: 'Weight'),
          ),
          TextField(
            controller: _heightController,
            decoration: InputDecoration(labelText: 'Height'),
          ),
          TextField(
            controller: _bloodTypeController,
            decoration: InputDecoration(labelText: 'Blood Type'),
          ),
          ElevatedButton(
            onPressed: _saveProfile,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
