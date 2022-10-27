import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Models/job_model.dart';
import 'package:guard_app/Models/user_model.dart';
import 'package:guard_app/services/markers.dart';

final dataProvier = Provider(((ref) => DataProvider()));

class DataProvider {
  static UserModel currentUser = UserModel(
      cvUrl: "https://www.dgvaishnavcollege.edu.in/dgvaishnav-c/uploads/2021/01/dummy-profile-pic.jpg",
      firstName: "",
      profilePicUrl: "",
      summary: "",
      job: "",
      lastName: "",
      workExperience: "");

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<JobModel>> getActiveJobs() async {
    var tempData =
        await firestore.collection('Guard').doc(auth.currentUser?.uid).get();

    bool isdelted = tempData.data()?['deletd'] ?? false;

    if (isdelted) {
      FirebaseAuth.instance.signOut();
      EasyLoading.showError(
          "Your account has been delted please contact admin");
    }
    
    List<JobModel> _jobList = [];
    var data = await firestore
        .collection('Guard')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('jobs')
        .where('pending', isEqualTo: true)
        .get();

    var iter = data.docs.iterator;

    while (iter.moveNext()) {
      var booking = iter.current.data();
      var item = JobModel.fromMap(booking);
      
      MapMarkers.makeMarkers(
          item.hirerName, item.description, item.latitude, item.longitude);

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

    return 0.0;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('Guard').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    currentUser = user ??
        UserModel(
            cvUrl: "",
            firstName: "",
            profilePicUrl: "",
            summary: "",
            job: "",
            lastName: "",
            workExperience: "");
    return user;
  }
}
