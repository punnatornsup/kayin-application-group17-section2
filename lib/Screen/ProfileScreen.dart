import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'EditProfileScreen.dart';

class UserProfile {
  String name;
  String age;
  String medicalCondition;
  String weight;
  String height;
  String bloodType;
  ImageProvider profileImage;

  UserProfile({
    this.name = '',
    this.age = '',
    this.medicalCondition = '',
    this.weight = '',
    this.height = '',
    this.bloodType = '',
    ImageProvider? profileImage,
  }) : profileImage = profileImage ??
            AssetImage('images/userprofile.png'); // Default image
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile userProfile =
      UserProfile(); // This should eventually be populated with real user data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 149, 183, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 149, 183, 255),
          title: Text('My profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: userProfile.profileImage,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userInfoRow('Name', userProfile.name),
                  userInfoRow('Age', userProfile.age),
                  userInfoRow(
                      'Medical Condition', userProfile.medicalCondition),
                  userInfoRow('Weight', userProfile.weight),
                  userInfoRow('Height', userProfile.height),
                  userInfoRow('Blood Type', userProfile.bloodType),
                  ElevatedButton(
                    onPressed: () async {
                      // Pass the current userProfile object to the EditProfileScreen
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(user: userProfile),
                        ),
                      );

                      // If the EditProfileScreen returns a new user profile, update the state
                      if (result != null) {
                        setState(() {
                          userProfile = result;
                        });
                      }
                    },
                    child: Text('Edit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa', color: Colors.black)),
                ),
                ],
              ),
            ),
          ],
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
                  Navigator.pushReplacement(
                    // Use pushReplacement to avoid stacking multiple home screens
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person, size: 40),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }

  Widget userInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Comfortaa',color: Colors.white)),
          Text(value.isNotEmpty ? value : 'Not set', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa', color: Colors.black)),
        ],
      ),
    );
  }
}
