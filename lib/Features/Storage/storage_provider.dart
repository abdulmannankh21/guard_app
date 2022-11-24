import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:guard_app/Views/Steps/step2.dart';
import 'package:guard_app/Views/Steps/step3.dart';
import 'package:guard_app/Views/Steps/step4.dart';
import 'package:riverpod/riverpod.dart';

final storageProvider = Provider((ref) => StorageMethods(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance));

class StorageMethods {
  StorageMethods(
      {required this.auth, required this.firestore, required this.storage});

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  // adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, File file) async {
    // creating location to our firebase storage

    Reference ref = storage.ref().child(childName).child(auth.currentUser!.uid);

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateUserData(
      {required String firstName,
      required String secondName,
      required String dateOfBirth,
      required String address,
      required String work,
      required String adress,
      required  String profileImageUrl,
      required String summary,

      }) async {
    
    await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .update(
      {
        'firstName': firstName,
        'secondName': secondName,
        'dateOfBirth': dateOfBirth,
        'address': address,
        'profilePicUrl':profileImageUrl,
        'summary': summary, 
        'workExperience': work

      },
    ).then((value) {
      EasyLoading.showSuccess("Data added successfully");
    
    }).catchError((error) {
      EasyLoading.showError("Failed to update try again");
    });
  }

  Future<void> saveUser(
      { required double latitude,
        required double longitude,
        required String selectedService,
        required String city,
        required String token,
        required String firstName,
      required String secondName,
      required String dateOfBirth,
      required String email,
      required String address,
      required String password,
      required BuildContext context}) async {
    firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('jobs')
        .doc();
    await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .set(

      { 'deleted':false,
         'service':selectedService,
         'latitude':latitude,
         'longitude':longitude,
        'uid':FirebaseAuth.instance.currentUser?.uid,
        'city':city.trim().toLowerCase(),
        'firstName': firstName,
        'secondName': secondName,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'password': password,
        'address': address,
        'token':token
        
      },SetOptions(merge: true))
    .then((value) {
      EasyLoading.showSuccess("Data added successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Step2()),
      );
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }

  Future<void> saveImages(
      {required BuildContext context,
      required String isaURl,
      required String profilePicUrl,
      required String cvUrl,
      required String identityUrl,
      }) async {
    await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .set({
      'profilePicUrl': profilePicUrl,
      'identityUrl': identityUrl,
      'cvUrl': cvUrl,
      'isaUrl': isaURl,
    
    }, SetOptions(merge: true)).then((value) {
      EasyLoading.showSuccess("Pictures Uploaded Successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Step3()),
      );
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }

  Future<void> addDetail(
      {required String age,
        required String height,
        required String physicalAttribute,
        required String summary,
      required String workExperience,
      required BuildContext context}) async {
    try {
      firestore
          .collection('Guard')
          .doc(auth.currentUser?.uid)
          .set({'verified': false}, SetOptions(merge: true));

     
      await firestore
          .collection('Guard')
          .doc(auth.currentUser?.uid)
          .collection('Basic')
          .doc('Earning')
          .set({"totalEarning": 0.0});

      await firestore
          .collection('Guard')
          .doc(auth.currentUser?.uid)
          .set({'summary': summary, 'workExperience': workExperience,'age':age,'height':height,'physicalAttribute':physicalAttribute},
              SetOptions(merge: true)).then((value) {
        EasyLoading.showSuccess("Data Added Succesfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Step4()),
        );
      });
    } catch (err) {
    
    }
  }
}
