

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_app/Common/common_firebase_repo_provider.dart';
import 'package:guard_app/Models/user_model.dart';
import 'package:guard_app/Views/Steps/step1.dart';
import 'dart:io';

import 'package:guard_app/Views/otp.dart';
import 'package:guard_app/Views/password.dart';



final authrepoProvider = Provider((ref) => AuthRespository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRespository {
  late final FirebaseAuth auth;
  late final FirebaseFirestore firestore;

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  

  AuthRespository({required this.auth, required this.firestore});

  void signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: ((verificationId) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: ((context) => PinCodeVerificationScreen(verificationId: verificationId))));
      }),
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential).then((value) {
               Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Step1()));
      print("You phone is verified ");
      Fluttertoast.showToast(
          msg: "You phone number is verified succesfully in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });;

        //verification completed
        
      },
      codeSent: (String verificationId, forceResendingToken) {},
      phoneNumber: phoneNumber,
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {}

        // Handle other errors
      },
    );
  }

  //Google verification
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential? userCredential =
            await auth.signInWithCredential(credential).then((value) {
               Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Step1()));
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });

        user = userCredential?.user;
        print(user!.email);
        //verification completed
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => Password())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content:
                  'The account already exists with a different credential.',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          
        
        }
      } catch (e) {
        
        //add handling
      }
    }

    return user;
  }

  //OTP verification

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      print(userOTP);
      print(verificationId);

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => Password())));
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

 
  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  
}
