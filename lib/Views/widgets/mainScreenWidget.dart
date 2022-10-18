import 'package:flutter/material.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:guard_app/Views/widgets/google_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends ConsumerState<MainScreenWidget> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isOnline = true;

  @override
  void initState() {
    // TODO: implement initState
    ref.read(dataProvier).getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          //Map
          child: Map(),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                // ignore: prefer_const_constructors
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.03, right: size.width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "You are active",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container(
                              height: 40.0,
                              child: LiteRollingSwitch(
                                value: true,
                                textOn: 'Active',
                                textOnColor: Colors.lightGreenAccent,
                                textOff: 'Inactive',
                                textOffColor: Colors.red,
                                colorOn: Colors.black,
                                colorOff: Colors.black,
                                iconOn: Icons.person,
                                iconOff: Icons.person_off,
                                onChanged: (bool state) {
                                  firestore
                                      .collection('Guard')
                                      .doc(auth.currentUser!.uid)
                                      .set({'active': state});
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      const Text(
                        "In Progress",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(51, 72, 159, 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        height: size.height * 0.08,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Steve Smith - key holding",
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Monday, 16 June | 10:00am - 12:00am",
                                    style: TextStyle(
                                        fontSize: size.width * 0.03,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "123",
                                    style: TextStyle(
                                        fontSize: size.width * 0.03,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
