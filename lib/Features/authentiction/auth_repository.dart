import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guard_app/Views/Steps/step1.dart';
import 'package:guard_app/Views/screens/mainScreen.dart';
import 'package:guard_app/Views/screens/otp.dart';
import 'package:guard_app/Views/screens/password.dart';

final authrepoProvider = Provider((ref) => AuthRespository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRespository {
  AuthRespository({required this.auth, required this.firestore});

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateEmail(String email) async {
    print(email);
    await auth.currentUser!.updateEmail(email).then((value) {
      EasyLoading.showSuccess("Email updated successfully");
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString().split(']').last);
    });
  }

  void updatePassword(String pass) async {
    await auth.currentUser!.updatePassword(pass).then((value) {
      EasyLoading.showSuccess("Pasword Updated Succesfully");
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString().split(']').last);
    });
  }

  void resetPasword(String email, BuildContext context) async {
    await auth.sendPasswordResetEmail(email: email).then((value) {
      EasyLoading.showSuccess("Email sent");
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      EasyLoading.showError("Error Occured ! Try Again");
    });
  }

  void signInwithEmailandPas(
      String email, String pass, BuildContext context) async {
    await auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      EasyLoading.showSuccess("LogIn succesfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => MainScreen())));
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString().split(']').last);
    });
  }

  void sigUpwithEmailAndPasword(
      {required String Email,
      required String Password,
      required BuildContext context}) async {
    final credential =
        EmailAuthProvider.credential(email: Email, password: Password);

    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential)
          .then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => Step1())));

        EasyLoading.showSuccess("LogIn success");
      });
    } on FirebaseAuthException catch (e) {
      String errorText = "Check your Internet Connection";
      switch (e.code) {
        case "weak-password":
          errorText = "weak-password";
          break;
        case "provider-already-linked":
          errorText = "The provider has already been linked to the user.";
          break;
        case "invalid-credential":
          errorText = "The provider's credential is not valid.";
          break;
        case "credential-already-in-use":
          errorText =
              "The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.";
          break;
        default:
          errorText = "Unknown error! Try Again";
      }

      EasyLoading.showError(e.toString().split(']').last);
    }
  }

  void signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    int? _resendtoken;
    await auth.verifyPhoneNumber(
      codeAutoRetrievalTimeout: ((verificationId) {
        EasyLoading.showInfo("code auto retrival time-out");
        Navigator.of(context).popAndPushNamed(
            PinCodeVerificationScreen.routeName,
            arguments: verificationId);
      }),
      verificationCompleted: (phoneAuthCredential) async {
        auth.signInWithCredential(phoneAuthCredential).then((value) {
          if (value.additionalUserInfo!.isNewUser) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => PasswordScreen())));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => MainScreen())));
          }

          EasyLoading.showInfo("Phone Verification Completed");
        }).onError((error, stackTrace) {
          EasyLoading.showError(error.toString());
        });

        //verification completed
      },
      codeSent: (String verificationId, forceResendingToken) {
        EasyLoading.showInfo("OTP sent");
      },
      phoneNumber: phoneNumber,
      forceResendingToken: _resendtoken,
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.showError(e.toString().split(']').last);

        // Handle other errors
      },
    );
  }

  //Google verification
  Future<User?> signInWithGoogle({required BuildContext context}) async {
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
        auth.signInWithCredential(credential).then((value) {
          EasyLoading.showSuccess("Gmail SignIn succes");
          if (value.additionalUserInfo!.isNewUser) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => PasswordScreen())));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => MainScreen())));
          }
        }).onError((error, stackTrace) {
          EasyLoading.showError(error.toString().split(']').last);
        });

        //verification completed

      } on FirebaseAuthException catch (e) {
        EasyLoading.showError(e.toString().split(']').last);
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
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential).then((value) {
        if (value.additionalUserInfo!.isNewUser) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => PasswordScreen())));
        }
        else
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => MainScreen())));
        }
      }).onError((error, stackTrace) {
        EasyLoading.showError(error.toString().split(']').last);
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.toString().split(']').last);
    }
  }
}
