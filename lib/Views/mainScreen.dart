import 'package:flutter/material.dart';
import 'package:guard_app/Views/jobs.dart';
import 'package:guard_app/Views/profile.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 'details_profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {},
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
                      MaterialPageRoute(builder: (context) => DetailsScreen()));
                },
                icon: Icon(Icons.person_outline),
              ),
              label: "Profile"),
        ],
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage("images/maps.png"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 00, top: 40),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0),
                            child: TextField(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black45,
                                  ),
                                  hintText: "Search",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.47),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0))),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.03,
                                    right: size.width * 0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Text(
                                              "You are active",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Container(
                                              height: 40.0,
                                              child: LiteRollingSwitch(
                                                value: true,
                                                textOn: 'Active',
                                                textOff: 'inactive',
                                                colorOn: Colors.black,
                                                colorOff: Colors.blueGrey,
                                                iconOn:
                                                    Icons.admin_panel_settings,
                                                iconOff:
                                                    Icons.admin_panel_settings,
                                                onChanged: (bool state) {
                                                  print(
                                                      'turned ${(state) ? 'on' : 'off'}');
                                                },
                                                onDoubleTap: () {},
                                                onTap: () {},
                                                onSwipe: () {},
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: size.height * 0.05),
                                      child: Text(
                                        "In Progress",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.01,
                                          right: size.width * 0.01,
                                          top: size.height * 0.01),
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.02,
                                          right: size.width * 0.02,
                                          top: size.height * 0.01),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(51, 72, 159, 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      height: size.height * 0.08,
                                      width: size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Steve Smith - key holding",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "Monday, 16 June | 10:00am - 12:00am",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.03,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                "123",
                                                style: TextStyle(
                                                    fontSize: size.width * 0.03,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
