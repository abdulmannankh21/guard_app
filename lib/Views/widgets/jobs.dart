import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * .1,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Jobs",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
        ),
        Container(
          height: size.height * 0.7,
          width: size.width,
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    top: size.height * 0.015),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
