import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard_app/Models/guard_model.dart';
import 'package:guard_app/Views/profile.dart';

import 'jobs.dart';
import 'mainScreen.dart';
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();


}

class _DetailsScreenState extends State<DetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  GuardDetails loggedInUser = GuardDetails();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("guard")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = GuardDetails.fromJson(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                        MaterialPageRoute(builder: (context) => MainScreen()));
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
                        MaterialPageRoute(builder: (context) => DetailsScreen()));
                  },
                  icon: Icon(Icons.person_outline),
                ),
                label: "Profile"),
          ],
        ),
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: size.height*0.12,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(left:size.width*0.02,top: size.height*0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        child: Image.network("${loggedInUser.photoURL}"),
                      ),
                      Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.amber,
borderRadius: BorderRadius.circular(7.0)
                        ),
                        child: Center(
                          child: Text(
                            "Hire",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color:
                                Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "${
                        loggedInUser.displayName
                        }",
                        style: TextStyle(
                            fontWeight:
                            FontWeight
                                .bold,
                            fontSize: 15,
                            color: Colors
                                .black),
                      ),
                      SizedBox(width: 5.0,),
                      Icon(Icons.verified,color: Colors.grey,)
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.045,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "About",
                    style: TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                        fontSize: size.width*0.07,
                        color: Colors
                            .black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${loggedInUser.summary}",
                    style: TextStyle(

                        fontSize: size.width*0.04,
                        color: Colors
                            .grey),
                  ),
                ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints.expand(height: 30),
                          child: TabBar(
                              labelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.label,

                              tabs: [
                            Tab(text: "Jobs"),

                            Tab(text: "Reviews"),
                          ]),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            Column(
                              children: [
                                getJobs(size),
                              ],
                            ),
                           Column(
                             children: [
                               getCustomRow(size),
                               getCustomRow(size),
                               getCustomRow(size),
                               getCustomRow(size),
                             ],
                           )

                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                ]
            ),
          )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget getJobs(size){
    return  Container(
      margin: EdgeInsets.only(left: size.width*0.01,right: size.width*0.01,top: size.height*0.01),
      padding: EdgeInsets.only(left: size.width*0.02,right: size.width*0.02,top: size.height*0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 254, 1),
          borderRadius: BorderRadius.circular(10.0)
      ),
      height: size.height*0.08,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Steve Smith - key holding",style: TextStyle(fontSize: size.width*0.04,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Text("Monday, 16 June | 10:00am - 12:00am",style: TextStyle(fontSize: size.width*0.03,color: Colors.grey,fontWeight: FontWeight.w300),),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.star,size: 10.0,),
              SizedBox(height: 10.0,),
              Text("5.3",style: TextStyle(fontSize: size.width*0.024,color: Colors.black,fontWeight: FontWeight.w300),),

            ],
          ),
        ],
      ),
    );
  }
  Widget getCustomRow(size){
    return Container(
      margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("5 Stars"),

          Container(
            margin: EdgeInsets.only(left: 10.0,right: 10.0),
            width: size.width*0.7,
            height: 9.0,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(60.0),

            ),
          ),
          Text("110"),

        ],
      ),
    );
  }
}
