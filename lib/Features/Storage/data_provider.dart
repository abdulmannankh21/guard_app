

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Models/job_model.dart';
import 'package:guard_app/Models/user_model.dart';

final dataProvier = Provider(((ref) => DataProvider()));

class DataProvider {
  static UserModel currentUser = UserModel(
      firstName: "",
      profilePicUrl: "",
      summary: "",
      job: "",
      lastName: "",
      workExperience: "");

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<JobModel>> getActiveJobs(String id) async {
    List<JobModel> _jobList = [];
    var data = await firestore
        .collection('Guard')
        .doc(id)
        .collection('jobs').where('pending',isEqualTo: true)
        .get();

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var booking = iter.current.data();
      var item = JobModel.fromMap(booking);

      _jobList.add(item);

      //_jobList.add(job);
    }
    return _jobList;
  }

  Future<List<JobModel>> getJobs() async {
    List<JobModel> _jobList = [];
    var data = await firestore
        .collection('Guard')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('jobs')
        .get();

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var booking = iter.current.data();
      var item = JobModel.fromMap(booking);

      _jobList.add(item);

      //_jobList.add(job);
    }
    return _jobList;
  }

  Future<double> getUserEarning() async {
    var userData = await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('Earning')
        .get();

    print(userData.data());

    return 0.0;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    currentUser = user!;
    return user;
  }
}
