import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'AddPillScreen.dart';
import 'ProfileScreen.dart';
import 'InformationScreen.dart';
// import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  final String useremail;
  HomeScreen({required this.useremail});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> pills = [];
  String useremail = "";
  String userid = '';
  String pillId = '';

  @override
  void initState() {
    super.initState();
    useremail = widget.useremail;
    initializeUserID();
  }

  Future<void> initializeUserID() async {
    await getUserID(widget.useremail);
  }

  Future<void> getUserID(String email) async {
    var userQuery = await FirebaseFirestore.instance
        .collection('Kayin_User')
        .where('Email',
            isEqualTo: email) // Changed to use the passed 'email' variable
        .get();
    if (userQuery.docs.isNotEmpty) {
      // Check if documents are returned
      setState(() {
        userid = userQuery.docs[0].id;
      });
    } else {
      // Handle the case where the user is not found
      print('User not found');
    }
  }

  Future<void> getPillID(String name) async {
    if (userid.isNotEmpty) {
      // Ensure userid is set before calling
      var userQuery = await FirebaseFirestore.instance
          .collection('Kayin_User')
          .doc(userid)
          .collection('pills')
          .where('name', isEqualTo: name)
          .get();
      if (userQuery.docs.isNotEmpty) {
        setState(() {
          pillId = userQuery.docs[0].id;
        });
      } else {
        // Handle the case where no pill is found for the given name
        print('Pill not found');
      }
    }
  }

  void _showAddPillsPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
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
                  const Text('Add Pills',
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
                              builder: (context) => AddPillScreen(
                                    useremail: useremail,
                                  )),
                        );
                        if (result != null) {
                          setState(() {
                            pills.add(result as Map<String, dynamic>);
                          });
                        }
                      },
                      child: const Text(
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
                      child: const Text(
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
        title: Text('Home',
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
                MaterialPageRoute(
                    builder: (context) => InformationScreen(
                          useremail: useremail,
                        )),
              );
            },
          ),
        ],
      ),
      body: userid.isNotEmpty
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(
                      'Kayin_User') // Assuming 'Kayin_User' is your user collection
                  .doc(userid) // The user's document ID
                  .collection('pills')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No Pills Found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var pill = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    bool isReminderOn = pill['isReminderOn'] ?? false;

                    return Card(
                      color: Color.fromARGB(255, 82, 121, 189),
                      elevation: 4.0,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        leading: Switch(
                          value: isReminderOn,
                          onChanged: (bool value) async {
                            await getPillID(pill['name']);
                            // Assuming pillDocument.id contains the ID of the pill
                            await FirebaseFirestore.instance
                                .collection('Kayin_User')
                                .doc(userid)
                                .collection('pills')
                                .doc(pillId)
                                .update({'isReminderOn': value});
                          },
                          activeTrackColor: Color.fromARGB(255, 150, 255, 179),
                          activeColor: Colors.green,
                        ),
                        // ... other ListTile properties
                        title: Text(pill['name'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
                            )),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(
                              Icons.alarm,
                              size: 16,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              // Wrap with Expanded
                              child: Text(
                                '${pill['time']} - ${pill['days'].join(", ")}',
                                overflow: TextOverflow
                                    .ellipsis, // Prevent text from overflowing
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Comfortaa',
                                ), // Adjust font size if necessary
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              size: 30,
                              color: Color.fromARGB(255, 227, 116, 108)),
                          onPressed: () async {
                            await getPillID(pill['name']);
                            // Delete the pill from Firestore
                            FirebaseFirestore.instance
                                .collection('Kayin_User')
                                .doc(userid)
                                .collection('pills')
                                .doc(pillId) // Use the document ID
                                .delete()
                                .then((_) => print('Pill deleted'))
                                .catchError(
                                    (error) => print('Delete failed: $error'));
                          },
                        ), // Adjusted the icon size
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 242, 149, 80),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            useremail: useremail,
                          )),
                );
              },
            ),
            IconButton(
              onPressed: _showAddPillsPopup,
              icon: SizedBox(
                width: 80, // Set your width
                height:
                    80, // Set your height, keep it the same as width for a square aspect ratio
                child: Image.asset(
                  'images/LogoKAYIN.jpg',
                  width: 100,
                  height: 200,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            useremail: widget.useremail,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
