import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/editprofile.dart';
import 'package:guard_app/Views/screens/password.dart';

import 'package:guard_app/Views/screens/update_email.dart';
import 'package:guard_app/Views/screens/update_pasword.dart';
import 'package:guard_app/services/location_services.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            ListTile(
              title: Text('Edit Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileScreen()));
              },
            ),
            ListTile(
              title: Text('Update Email'),
              leading: Icon(Icons.message_outlined),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdateEmailScreen()));
              },
            ),
            ListTile(
              title: Text('Update Password'),
              leading: Icon(Icons.password_rounded),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UpdatePasswordScreen()));
              },
            ),
            ListTile(
              title: Text('Enable Location'),
              leading: Icon(Icons.location_on),
              onTap: () {
                LocationServices.requestLocationPermission();
              },
            ),
          ],
        ),
      ),
    );
  }
}
