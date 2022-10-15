import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guard_app/Views/Steps/step2.dart';
import 'package:guard_app/Views/Steps/step3.dart';
import 'package:guard_app/Views/Steps/step4.dart';
import 'package:riverpod/riverpod.dart';

final storageProvider = Provider((ref) => StorageMethods(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance));

class StorageMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StorageMethods(
      {required this.auth, required this.firestore, required this.storage});

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

  Future<void> saveUser(
      {required String firstName,
      required String secondName,
      required String dateOfBirth,
      required String email,
      required String address,
      required String password,
      required BuildContext context}) async {
    firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('jobs').doc();
    await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .set(
      {
        'firstName': firstName,
        'secondName': secondName,
        'dateOfBirth': dateOfBirth,
        'email': email,
        'password': password,
        'address': address
      },
    ).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(content: "Data aded succesfully"));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Step2()),
      );
    }).catchError((error) => Fluttertoast.showToast(
            msg: "Failed to Add",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
  }

  Future<void> saveImages(
      {required BuildContext context,
      required String idFrontURl,
      required String profilePicUrl,
      required String idBackUrl,
      required String licenseFrotUrl,
      required String licenseBackUrl}) async {
    await firestore
        .collection('Guard')
        .doc(auth.currentUser?.uid)
        .collection('Basic')
        .doc('info')
        .set({
      'profilePicUrl': profilePicUrl,
      'idFrontURl': idFrontURl,
      'idBackUrl': idBackUrl,
      'licenseFrotUrl': licenseFrotUrl,
      'licenseBackUrl': licenseBackUrl
    }, SetOptions(merge: true)).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(content: "Data aded succesfully"));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Step3()),
      );
    }).catchError((error) => Fluttertoast.showToast(
            msg: "Failed to Add",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0));
    ;
    ;
  }

  Future<void> addDetail(
      {required String summary,
      required String workExperience,
      required BuildContext context}) async {
    try {
      await firestore
          .collection('Guard')
          .doc(auth.currentUser?.uid)
          .collection('Basic')
          .doc('info')
          .set({'summary': summary, 'workExperience': workExperience},
              SetOptions(merge: true)).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(customSnackBar(content: "Data aded succesfully"));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Step4()),
        );
      });
    } catch (err) {
      // ignore: avoid_print
      print(err);
    }
  }
}
