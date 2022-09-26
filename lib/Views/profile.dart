import 'package:flutter/material.dart';

import 'jobs.dart';
import 'mainScreen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 254, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //rgba(255,255,254,255)
                  color: Color.fromRGBO(255, 255, 254, 1),

                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Accounts",
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.notifications_none_outlined,
                            size: size.width * 0.08,
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, top: size.height * 0.03),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.22,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black26),
                              child: ClipRRect(
                                child: Image.asset(
                                  "images/cars.png",
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "John Doe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Divider(
                        color: Colors.black12,
                      ),
                      customTile("Membership", Icons.wallet_giftcard),
                      Divider(
                        color: Colors.black12,
                      ),
                      customTile(
                          "Notifications", Icons.notifications_none_outlined),
                      customTile("Support", Icons.support),
                      customTile("Settings", Icons.settings),
                      Divider(
                        color: Colors.black12,
                      ),
                      customTile("About", Icons.info),
                      Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:size.width*0.4,top:10.0),
                        child: Text("Logout"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,

        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScree()));
                },
                icon: Icon(Icons.home),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  //
                  // //
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Bookings()));
                },
                icon: Icon(Icons.my_library_books),
              ),
              label: "Earnings"),

          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JobsScreen()));
                },
                icon: Icon(Icons.local_activity_outlined),
              ),
              label: "Jobs"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                icon: Icon(Icons.person_outline),
              ),
              label: "Profile"),
        ],
      ),
    );
  }

  Widget customTile(name, icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text("$name"),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.grey,
      ),
    );
  }
}
