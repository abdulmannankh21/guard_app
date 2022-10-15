

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Models/job_model.dart';
import 'package:guard_app/Models/user_model.dart';

final dataProvier = Provider(((ref) => DataProvider()));

class DataProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  static UserModel currentUser = UserModel(
      firstName: "",
      profilePicUrl: "",
      summary: "",
      job: "",
      lastName: "",
      workExperience: "");
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

  Future<JobModel?> getJobs() async {
    var userData;
    userData = firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('Jobs')
        .get();

    return userData;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    currentUser = user!;
    return user;
  }
}
