
import 'package:flutter/material.dart';

import 'package:guard_app/Common/Services/markers.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:guard_app/Models/job_model.dart';
import 'package:guard_app/services/local_notification_service.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isNoJobs = false;

  bool isActive = true;

  List<JobModel> jobs = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    MapMarkers.clearMarker();
    ref.read(dataProvier).getCurrentUserData();
    getJobs();

    LocalNotificationService.requestPermission();
  }

  Future<void> getJobs() async {
    var data = await ref.read(dataProvier).getActiveJobs();

    setState(() {
      if (data.isEmpty) {
        isNoJobs = true;
      }
      jobs = data;
      loading = false;
    });
  }

  Widget listItem(String header, String duration, double fee, var size) {
    return Column(
      children: [
        SizedBox(
          height: 2,
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
                      header,
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      duration,
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
                      fee.toString(),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * .50,
                  //Map
                  child: Map(),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.70,
                        width: MediaQuery.of(context).size.width,
                        // ignore: prefer_const_constructors
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.03,
                              right: size.width * 0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isActive
                                        ? Text(
                                            "You are active",
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        : Text(
                                            "You are Inactive",
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
                                              .set({'active': state},
                                                  SetOptions(merge: true));

                                          setState(() {
                                            isActive = !isActive;
                                          });
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
                              SizedBox(
                                height: size.height * .5,
                                width: size.width,
                                child: jobs.isEmpty
                                    ? Center(child: Text(" No current jobs "))
                                    : ListView.builder(
                                        itemCount: jobs.length,
                                        itemBuilder: ((context, index) =>
                                            listItem(
                                                jobs[index].hirerName +
                                                    " - " +
                                                    jobs[index]
                                                        .description
                                                        .split(',')
                                                        .first,
                                                jobs[index].weekDay +
                                                    " | " +
                                                    jobs[index].date +
                                                    " | " +
                                                    jobs[index].duration,
                                                jobs[index].fee,
                                                size))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
