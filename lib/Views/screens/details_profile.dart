import 'package:flutter/material.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:guard_app/Models/job_model.dart';
import 'package:guard_app/Models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  bool loading = true;
  UserModel? user;
  List<JobModel> completedJob = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    var value = await ref.read(dataProvier).getCurrentUserData();

    var jobs = await ref.read(dataProvier).getJobs();

    setState(() {
      user = value;
      completedJob = jobs;
      loading = false;
    });
  }

  Widget getJobs(size, String header, String body) {
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 0.01,
          right: size.width * 0.01,
          top: size.height * 0.01),
      padding: EdgeInsets.only(
          left: size.width * 0.02,
          right: size.width * 0.02,
          top: size.height * 0.01),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 254, 1),
          borderRadius: BorderRadius.circular(10.0)),
      height: size.height * 0.08,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "steve smith -key holding",
                style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Monday, 16 June | 10:00am - 12:00am",
                style: TextStyle(
                    fontSize: size.width * 0.03,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                size: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "",
                style: TextStyle(
                    fontSize: size.width * 0.024,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getCustomRow(size) {
    return Container(
        height: size.height * .50,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(user?.cvUrl??"https://www.dgvaishnavcollege.edu.in/dgvaishnav-c/uploads/2021/01/dummy-profile-pic.jpg"),fit: BoxFit.fill)));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.grey),
            )
          : Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.02, top: size.height * 0.01),
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
                          backgroundImage:
                              NetworkImage("${user?.profilePicUrl}"),
                          radius: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "${user?.firstName}  ${user?.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.045,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "About",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.07,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${user?.summary}",
                      style: TextStyle(
                          fontSize: size.width * 0.04, color: Colors.grey),
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
                                    constraints:
                                        BoxConstraints.expand(height: 30),
                                    child: TabBar(
                                        labelColor: Colors.black,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        tabs: [
                                          Tab(text: "Jobs"),
                                          Tab(text: "Cv"),
                                        ]),
                                  ),
                                  Expanded(
                                    child: TabBarView(children: [
                                      SizedBox(
                                        height: size.height * .40,
                                        child: ListView.builder(
                                            itemCount: completedJob.length,
                                            itemBuilder: ((context, index) =>
                                                getJobs(
                                                    size,
                                                    completedJob[index]
                                                            .hirerName +
                                                        "-" +
                                                        completedJob[index]
                                                            .description,
                                                    completedJob[index]
                                                            .weekDay +
                                                        " " +
                                                        completedJob[index]
                                                            .date +
                                                        " | " +
                                                        completedJob[index]
                                                            .duration))),
                                      ),
                                      Column(
                                        children: [
                                          getCustomRow(size),
                                      
                                        ],
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
    );
  }
}
