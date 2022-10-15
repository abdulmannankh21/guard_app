import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guard_app/Models/user_model.dart';

final dataProvier = Provider(((ref) => DataProvider()));

class DataProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .get();

    

    UserModel? user ;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
      
    }
    return user;
  }
}
