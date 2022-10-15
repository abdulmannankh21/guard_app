import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/mainScreen.dart';
import 'package:guard_app/Views/widgets/profile.dart';


class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03, right: size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //rgba(255,255,254,255)
                color: Color.fromRGBO(255, 255, 254, 1),

                height: size.height * 0.32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bookings",
                          style: TextStyle(
                              fontSize: size.width * 0.06,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.notifications_none_outlined,
                          size: size.width * 0.08,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "6-12 March 2022",
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: size.width * 0.17,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(80.0)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Week",
                                    style: TextStyle(
                                        fontSize: size.width * 0.03,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.event,
                                    size: size.width * 0.04,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          customCol("Wed", "6", size),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    top: size.height * 0.07),
                padding: EdgeInsets.only(
                    left: size.width * 0.02,
                    right: size.width * 0.02,
                    top: size.height * 0.01),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 254, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                height: size.height * 0.08,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monday, 7 March",
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                        Text(
                          "10:00am-12:00am",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
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
    );
  }

  Widget customCol(day, date, size) {
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$day",
            style: TextStyle(
                fontSize: size.width * 0.05,
                color: Color.fromRGBO(198, 198, 201, 1)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            "$date",
            style: TextStyle(fontSize: size.width * 0.05, color: Colors.black),
          )
        ],
      ),
    );
  }
}
