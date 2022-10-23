import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Features/Storage/data_provider.dart';
import 'package:guard_app/Models/job_model.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  bool isNoJobs = false;
  List<JobModel> jobs = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBookings();
  }

  Future<void> getBookings() async {
    var data = await ref.read(dataProvier).getJobs();

    setState(() {
      if (data.isEmpty) {
        isNoJobs = true;
      }
      jobs = data;
      loading = false;
    });
  }

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
          child:  loading?Center(child: isNoJobs?Text("No jobs found "): CircularProgressIndicator(),): ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
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
                      "${jobs[index].weekDay} | ${jobs[index].date} ",
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
                          jobs[index].duration,
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
